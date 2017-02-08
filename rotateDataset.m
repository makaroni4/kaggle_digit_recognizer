function rotateDataset(data, digitSize, outputFile)
  m = size(data, 1);

  for i = 1:m
    dataSample = data(i, :);
    digitVec = dataSample(:, 2:end);
    label = dataSample(:, 1);

    rotatedVersions = rotateDigit(digitVec, label, digitSize);

    dlmwrite(outputFile, rotatedVersions, '-append', 'delimiter', ',');
  end
end
