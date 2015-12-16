% Use Three groups to cluster
% function []= knn_version2()
    
    clear;
    load train_mean_vector;

    K1 = 100;
    K2 = 10;
    K3 = 5;

    nums = int16(size(TrainMatrix, 3) * 0.9);

    tt = squeeze(TrainMatrix)';

    [classifierX, classifierY, predictData, realY] = randomSplit(tt, nums, TrainY');
    % classifierX = TrainMatrix(:, :, 1:nums);
    % classifierX = squeeze(classifierX)';
    % classifierX1 = classifierX(:, 1:13);

    %  classifierY= TrainY(:, 1:nums)';

    % predictData = TrainMatrix(:, :, nums + 1:size(TrainMatrix, 3));
    % predictData = squeeze(predictData)';
    % realY = TrainY(:, nums + 1:size(TrainY, 2))';

    predictFilesNum = size(predictData, 1);
    predictY = zeros(size(predictData, 1), 1 );


    for i = 1 : size(predictData, 1)
        dataPoint = predictData(i,1:13);
        group1 = knnsearch(classifierX(:, 1:13), dataPoint, 'k', K1);

        dataPoint = predictData(i, 14:26);
        classifierX2 = classifierX(group1, :);
        classifierY2 = classifierY(group1, :);
        group2 = knnsearch(classifierX2(:, 14:26), dataPoint, 'k', K2);

        classifierX3 = classifierX2(group2, :);
        classifierY3 = classifierY2(group2, :);
        dataPoint = predictData(i, 27:39);
        group3 = knnsearch(classifierX3(:, 27:39), dataPoint, 'k', K3);
        predictY(i, 1) = mode(classifierY3(group3, :));
    %     predictY(1, i) = int16(sum(classifierY3(group3, :)) ./ length(group3));

    end

    accuracy = sum(predictY == realY) / length(predictData);
    fprintf('%f\n', accuracy);
    
% end
