graphics_toolkit('gnuplot');

clear ; close all; clc

fprintf('--> Reading train data\n')

data = readData('data/train.csv');

X = data(:, 2:end);
y = data(:, 1);
% Since there is no 0 index in Octave, 0 is 10
y(y == 0) = 10;

% displayTrainSample(data, 1);

input_layer_size  = 784;
hidden_layer_size = 800;
num_labels = 10;

initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

%  Check gradients by running checkNNGradients
% checkNNGradients;

fprintf('--> Training Neural Network\n')

options = optimset('MaxIter', 150);

lambda = 1;

% Create "short hand" for the cost function to be minimized
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, X, y, lambda);

[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);

Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

fprintf('--> Prediction train set\n')

pred = predict(Theta1, Theta2, X);

fprintf('-->Training Set Accuracy: %f\n', mean(double(pred == y)) * 100);

fprintf('--> Prediction test set\n')

predictTestSet('data/test.csv', 'output.csv', Theta1, Theta2);
