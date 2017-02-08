data = readData('data/train.csv');

filename = 'data/train_rotated.csv';
fid = fopen(filename, 'w');
fclose(fid);

rotateDataset(data, 28, filename);
