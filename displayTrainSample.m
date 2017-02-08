function displayTrainSample(data, i, boxSize)
  label = data(i, 1);
  sample = data(i, 2:end);

  colormap(gray);

  max_val = max(abs(sample));

  display_array = reshape(sample, boxSize, boxSize) / max_val;

  imagesc(display_array, [0 0]);

  axis image off;
  title(strcat(sprintf('Number %d', label)));

  drawnow;
end
