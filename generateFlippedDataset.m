filename = 'data/train_flipped_small_digits.csv';
fid = fopen(filename, 'w');
fclose(fid);

data = readData('data/train_small_digits.csv');
m = size(data, 1);
data = data(randperm(m), :);

for i = 1:m
  dataSample = data(i, :);
  digitVec = dataSample(:, 2:end);
  label = dataSample(:, 1);

  flipFunctions = ['flipud'; 'fliplr'];
  flipFunc = randsample([1, 2], 1);
  digitVec = feval(flipFunctions(flipFunc, :), digitVec);

  dlmwrite(filename, [label digitVec(:)'], '-append', 'delimiter', ',');
end
