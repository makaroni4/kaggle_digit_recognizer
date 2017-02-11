% http://stackoverflow.com/questions/39308301/expand-mnist-elastic-deformations-matlab
function newImage = distortImage(inputImage)
  imageSize = sqrt(size(inputImage, 2));
  inputImage = reshape(inputImage, imageSize, imageSize);

  dx = -1 + 2 * rand(size(inputImage));
  dy = -1 + 2 * rand(size(inputImage));

  sig = 4;
  alpha = 60;
  H = fspecial('gaussian', [7 7], sig);
  fdx = imfilter(dx, H);
  fdy = imfilter(dy, H);
  n = sum((fdx(:) .^ 2 + fdy(:) .^ 2)); %// norm (?) not quite sure about this "norm"
  fdx = alpha * fdx ./ n;
  fdy = alpha * fdy ./ n;

  [y x] = ndgrid(1:size(inputImage,1), 1:size(inputImage,2));
  % figure;
  % imagesc(inputImage);
  % colormap gray;
  % axis image;
  % axis tight;
  % hold on;
  % quiver(x, y, fdx, fdy, 0, 'r');

  newImage = griddata(x - fdx, y - fdy, double(inputImage), x, y);
  newImage(isnan(newImage)) = 0;

  newImage = floor(newImage);
  newImage(newImage == -0) = 0;

  % figure;
  % subplot(121); imagesc(inputImage); axis image;
  % subplot(122); imagesc(newImage); axis image;
  % colormap gray;
end
