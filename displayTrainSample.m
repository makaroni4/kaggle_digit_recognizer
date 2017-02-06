function displayTrainSample(data, i)
  label = data(i, 1);
  sample = data(i, 2:end);

  colormap(gray);

  height = 28;
  width = 28;

  max_val = max(abs(sample));

  display_array = reshape(sample, height, width) / max_val;

  imagesc(display_array, [0 0]);

  axis image off;
  title(strcat(sprintf('Number %d', label)));

  drawnow;
end
