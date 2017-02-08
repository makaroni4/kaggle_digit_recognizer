function X = normalizeX(X)
  m = size(X, 1);
  for i = 1:m
    max_val = max(abs(X(i, :)));
    X(i) = X(i) / max_val;
  end
end
