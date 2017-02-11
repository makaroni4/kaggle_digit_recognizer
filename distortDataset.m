function distortDataset(data)
  filename = 'data/train_distorted.csv';
  fid = fopen(filename, 'w');
  fclose(fid);

  m = size(data, 1);

  for i = 1:m
    dataSample = data(i, :);
    digitVec = dataSample(:, 2:end);
    label = dataSample(:, 1);

    newDigit = distortImage(digitVec);

    dlmwrite(filename, [label newDigit(:)'], '-append', 'delimiter', ',');
  end
end
