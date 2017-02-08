function predictTestSet(inputfile, outputfile, Theta1, Theta2)
  filename = outputfile;
  fid = fopen(filename, 'w');
  fprintf(fid, 'ImageId,Label\n');
  fclose(fid);

  X = readData(inputfile);
  X = normalizeX(X);
  m = size(X, 1);

  pred = predict(Theta1, Theta2, X);
  pred(pred == 10) = 0;
  pred = [diag(diag(1:(size(pred, 1)))) pred];

  dlmwrite(filename, pred, '-append', 'delimiter', ',');
end
