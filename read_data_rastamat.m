
test_path = './output/train.scp';
files = fileread(test_path);
files = strsplit(files, '\n');

NumTrainFiles = 3186;
TrainMatrix = zeros(NumTrainFiles, 1);


for i = 1 : length(files)
    filename = char(files(i));
    % store file name
    TrainMatrix(i,:) = filename;
    
end

