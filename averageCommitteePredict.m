function pred = averageCommitteePredict(X)
  nns = ['rotated'; 'flipped'; 'distorted'; 'train'];
  m = size(X, 1);
  num_labels = 10;

  sigmoids = zeros(m, num_labels);

  for i = 1:size(nns, 1)
    nnType = nns(i, :);
    load(strcat(nnType, '_theta1.txt'));
    load(strcat(nnType, '_theta2.txt'));

    h1 = sigmoid([ones(m, 1) X] * bestTheta1');
    h2 = sigmoid([ones(m, 1) h1] * bestTheta2');

    sigmoids = sigmoids .+ h2;
  end

  [dummy, pred] = max(sigmoids, [], 2);

  pred(pred == 10) = 0;

  pred = [diag(diag(1:(size(pred, 1)))) pred];

  filename = 'output.csv';
  fid = fopen(filename, 'w');
  fprintf(fid, 'ImageId,Label\n');
  fclose(fid);

  dlmwrite(filename, pred, '-append', 'delimiter', ',');
end
