filename = 'data/train_rotated_small_digits.csv';
fid = fopen(filename, 'w');
fclose(fid);

data = readData('data/train_rotated.csv');
% data = readData('data/test.csv');
m = size(data, 1);

for i = 1:m
  dataSample = data(i, :);
  digitVec = dataSample(:, 2:end);
  label = dataSample(:, 1);

  smallVersion = cropDigitBox(digitVec, 28, 20);

  dlmwrite(filename, [label smallVersion(:)'], '-append', 'delimiter', ',');
end
