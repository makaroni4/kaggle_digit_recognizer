function sample = cropDigitBox(sample, initialDigitSize, targetDigitSize)
  sample = reshape(sample, initialDigitSize, initialDigitSize);

  idx = all(sample == 0, 2);
  % cleanup middle empty lines:
  % 111010010111 should become 111000000111
  zeros_idx = find(idx == 0);
  first_zero_index = zeros_idx(1);
  last_zero_index = zeros_idx(end);
  idx(first_zero_index:last_zero_index) = 0;

  sample(idx, :) = [];

  idy = all(sample == 0, 1);
  zeros_idy = find(idy == 0);
  first_zero_index = zeros_idy(1);
  last_zero_index = zeros_idy(end);
  idy(first_zero_index:last_zero_index) = 0;
  sample(:, idy) = [];

  h = size(sample, 1);
  w = size(sample, 2);

  squareSize = max([h w targetDigitSize]);
  pad_h = floor((squareSize - h) / 2);
  pad_w = floor((squareSize - w) / 2);

  sample = padarray(sample, [pad_h, pad_w], 0);
  sample = round(imresize(sample, [targetDigitSize, targetDigitSize], 'bilinear'));
end
