function rotatedDigit = rotateDigit(digitVec, label, digitSize)
  rotatedDigit = [];

  digitMatrix = reshape(digitVec, digitSize, digitSize);

  for i = 1:3
    % image package could be found here:
    % https://octave.sourceforge.io/packages.php
    angle = (1 + rand() * 10) * randsample([1 -1], 1);
    newDigit = imrotate(digitMatrix, angle);
    newDigit = round(imresize(newDigit, [digitSize, digitSize], 'bilinear'));

    rotatedDigit = [rotatedDigit; [label newDigit(:)']];
  end
end
