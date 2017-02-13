function predictions = votingCommitteePredict(X)
  nns = ['rotated'; 'flipped'; 'distorted'; 'train'];
  predictions = [];

  for i = 1:size(nns, 1)
    m = size(X, 1);
    nnType = nns(i, :);
    load(strcat(nnType, '_theta1.txt'));
    load(strcat(nnType, '_theta2.txt'));

    pred = predict(bestTheta1, bestTheta2, X);
    pred(pred == 10) = 0;

    predictions = [predictions pred];
  end

  predictions = mode(predictions')';
  predictions = [diag(diag(1:(size(pred, 1)))) predictions];

  filename = 'output.csv';
  fid = fopen(filename, 'w');
  fprintf(fid, 'ImageId,Label\n');
  fclose(fid);

  dlmwrite(filename, predictions, '-append', 'delimiter', ',');
end
