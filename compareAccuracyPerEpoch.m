function compareAccuracyPerEpoch(folder)
  graphics_toolkit('gnuplot');
  files = glob(strcat(folder, '/*.dat'));

  xlabel('Epochs');
  ylabel('Accuracy on unseen (2000 items) dataset');
  title('Accuracy on unssed dataset per epoch');
  labels = {};
  colororder = get (gca, 'colororder');

  for i=1:numel(files)
    data = csvread(files{i})(2:end, :);
    h = plot(data(:, 1), data(:, 2));
    hold on;

    set (h, 'color', colororder(i,:));

    [pathstr, name, ext] = fileparts(files{i});
    name(name == '_') = ' ';
    labels = {labels{:}, [name]};
  end

  legend(labels, 'location', 'southoutside');
end
