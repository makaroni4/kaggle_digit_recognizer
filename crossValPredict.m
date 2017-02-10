function crossValAccuracy = crossValPredict(validation_data, nn_params, i)
  hidden_layer_size = 800;
  input_layer_size = 784;
  num_labels = 10;

  Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                   hidden_layer_size, (input_layer_size + 1));

  Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                   num_labels, (hidden_layer_size + 1));

  X = validation_data(:, 2:end);
  X = normalizeX(X);
  y = validation_data(:, 1);

  pred = predict(Theta1, Theta2, X);

  crossValAccuracy = mean(double(pred == y)) * 100;

  if crossValAccuracy > 98
    save mega_theta1.mat Theta1
    save mega_theta2.mat Theta2
  end

  fprintf('\n  Validation data accuracy: %f', crossValAccuracy);
end
