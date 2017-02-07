graphics_toolkit('gnuplot');

clear ; close all; clc

fprintf('--> Reading train data\n')

data = readData('data/train.csv');

X = data(:, 2:end);
y = data(:, 1);
% Since there is no 0 index in Octave, 0 is 10
y(y == 0) = 10;

% displayTrainSample(data, 1);

input_layer_size = 784;
hidden_layer_size = 800;
% lambda_vec = [0 0.001 0.003 0.01 0.03 0.1 0.3 1 3 10];
lambda_vec = [5];
maxIter = 10;

bestAccuracy = 0;
bestLambda = -1;
bestTheta1 = [];
bestTheta2 = [];

for i = 1:length(lambda_vec)
  lambda = lambda_vec(i);
  [trainSetAccuracy, Theta1, Theta2] = trainNN(lambda, X, y, input_layer_size, hidden_layer_size, maxIter);

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

predictTestSet('data/test.csv', 'output.csv', bestTheta1, bestTheta2);
