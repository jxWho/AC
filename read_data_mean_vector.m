addpath('./voicebox');
addpath('./MSR Identity Toolkit v1/code');

test_path = './output/train.scp';
files = fileread(test_path);
files = strsplit(files, '\n');
% maxRow = 0;
%  for i = 1:length(files)
%      tempString = char(files(i));
%      filename = strsplit(tempString, ':');
%      filename = filename(2);
%      filename = char(filename);
%     [Y, FS] = readwav(filename);
%     c = melcepst(Y, FS);
%     if maxRow < size(c, 1)
%         maxRow = size(c, 1);
%     end
% end
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
    % mean and variance normalizes the features
%     c = cmvn(c', true)';
    rows = size(c, 1);

    % mean vector
    c = sum(c) ./ rows;
    x = size(c,1);
    TrainMatrix(1:x, :, i) = c;
end

save 'train_mean_vector.mat' 'TrainY' 'maxRow' 'NumTrainFiles' 'TrainMatrix' ;
%save 'test.mat' 'TrainY' 'maxRow' 'NumTestFiles' 'TestMatrix' '-v7.3' ;