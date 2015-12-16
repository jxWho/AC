% function [ X, Y ] = read_data_SDC()
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    clear;
    
    addpath('./voicebox');
    addpath('./mfcc2sdc');

    % read Train data
    train_path = './output/train.scp';
    
    files = fileread(train_path);
    files = strsplit(files, '\n');

    N = 13;
    d = 1;
    p = 3;
    k = 3;

    cnt = 0;
%     for i = 1 : length(files)
%         tempString = char(files(i));
%         filename = strsplit(tempString, ':');
%         classNumber = str2num(char(filename(1)));
%     %     TrainY(i) = classNumber;
%         filename = filename(2);
%         filename = char(filename);
%         [Y, FS] = readwav(filename);
%         c = melcepst(Y, FS, '0dD');
%         c = pca(c);
%         % should I do PCA here?
% %         sdc_c = mfcc2sdc(c, N, d, p, k);
%         
% 
%         for j = 1 : size(c, 1)
%             cnt = cnt + 1;
%             TrainX(cnt, :) = c(j, :);
%             TrainY(cnt, 1) = classNumber;
%         end
% 
%     end
%     
%     save 'train_pca_sdc' 'TrainX' 'TrainY';
    
    % read test data
    test_path = './output/train.scp';
    files = fileread(test_path);
    files = strsplit(files, '\n');
    
    cnt = 0;
    for i = 1 : length(files)
        tempString = char(files(i));
        filename = strsplit(tempString, ':');
        classNumber = str2num(char(filename(1)));
    %     TrainY(i) = classNumber;
        YY(i, :) = classNumber;
        filename = filename(2);
        filename = char(filename);
        [Y, FS] = readwav(filename);
        c = melcepst(Y, FS, '0dD');
        c = cmvn(c', true)';
        c = pca(c);
        % should I do PCA here?
%         sdc_c = mfcc2sdc(c, N, d, p, k);

        for j = 1 : size(c, 1)
            cnt = cnt + 1;
            TestX(cnt, :) = c(j, :);
            TestY(cnt, 1) = classNumber;
        end

    end
    save 'test_pca_sdc' 'TestX' 'TestY' 'YY';
% end

