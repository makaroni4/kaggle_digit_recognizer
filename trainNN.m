function [trainSetAccuracy, Theta1, Theta2] = trainNN(lambda, X, y, input_layer_size, hidden_layer_size, maxIter, validationData)
  num_labels = 10;

  initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
  initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

  % Unroll parameters
  initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

  %  Check gradients by running checkNNGradients
  % checkNNGradients;

  fprintf('--> Training Neural Network\n');

  options = optimset('MaxIter', maxIter);

  lambda = 1;

  % Create "short hand" for the cost function to be minimized
  costFunction = @(p) nnCostFunction(p, ...
                                     input_layer_size, ...
                                     hidden_layer_size, ...
                                     num_labels, X, y, lambda);

  [nn_params, cost] = fmincg(costFunction, initial_nn_params, validationData, options);

  Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                   hidden_layer_size, (input_layer_size + 1));

  Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                   num_labels, (hidden_layer_size + 1));

  fprintf('--> Prediction train set\n');

  pred = predict(Theta1, Theta2, X);

  trainSetAccuracy = mean(double(pred == y)) * 100;

  fprintf('-->Training Set Accuracy: %f\n', trainSetAccuracy);
end
