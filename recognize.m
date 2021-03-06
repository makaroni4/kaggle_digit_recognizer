graphics_toolkit('gnuplot');

clear ; close all; clc

fprintf('--> Reading train data\n')

digit_size = 28;

% data = readData('data/train_small_digits.csv');
% data = [data; readData('data/train_rotated_small_digits.csv')];
% data = [data; readData('data/train_flipped_small_digits.csv')];

data = readData('data/train.csv');
m = size(data, 1);
data = data(randperm(m), :);

validationData = data(1:2000, :);
data = data(2001:end, :);
data = [data; readData('data/train_rotated.csv')];
m = size(data, 1);

X = data(:, 2:end);
X = normalizeX(X);

y = data(:, 1);
y(y == 0) = 10; % Since there is no 0 index in Octave, 0 is 10

input_layer_size = digit_size * digit_size;
hidden_layer_size = 800;
lambda_vec = [1];
maxIter = 1000;

bestAccuracy = 0;
bestLambda = -1;
bestTheta1 = [];
bestTheta2 = [];

for i = 1:length(lambda_vec)
  lambda = lambda_vec(i);
  [trainSetAccuracy, Theta1, Theta2] = trainNN(lambda, X, y, input_layer_size, hidden_layer_size, maxIter, validationData);

  fprintf('-->Accuracy for lambda %f is %f\n', lambda, trainSetAccuracy);

  if trainSetAccuracy > bestAccuracy
    bestAccuracy = trainSetAccuracy;
    bestLambda = lambda;
    bestTheta1 = Theta1;
    bestTheta2 = Theta2;
  end
end

fprintf('\n-->Best accuracy is %f for lambda %f is %f\n', bestAccuracy, bestLambda);

fprintf('--> Prediction test set\n');

save theta1.txt bestTheta1;
save theta2.txt bestTheta2;

predictTestSet('data/test.csv', 'output.csv', bestTheta1, bestTheta2);
