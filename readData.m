% Reading MNIST csv from kaggle where every row in CSV is 784 pixels
% Note: first raw is a header row
function X = readData(filename)
  X = csvread(filename)(2:end, :);
end
