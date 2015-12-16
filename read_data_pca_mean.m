addpath('./voicebox');

test_path = './output/train.scp';
files = fileread(test_path);
files = strsplit(files, '\n');

maxRow = 1;
NumTrainFiles = 5735;
TrainMatrix = zeros(maxRow, 39, 3186);
TrainY = zeros(1, 3186);
for i = 1 : length(files)
    tempString = char(files(i));
    filename = strsplit(tempString, ':');
    classNumber = str2double(char(filename(1)));
    TrainY(i) = classNumber;
    filename = filename(2);
    filename = char(filename);
    [Y, FS] = readwav(filename);
    c = melcepst(Y, FS, '0dD');
    c = pca(c);
    rows = size(c, 1);

    % mean vector
    c = sum(c) ./ rows;
    x = size(c,1);
    TrainMatrix(1:x, :, i) = c;
end

save 'train_pca_mean_vector.mat' 'TrainY' 'maxRow' 'NumTrainFiles' 'TrainMatrix' ;