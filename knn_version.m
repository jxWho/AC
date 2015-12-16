% function [accuracies]= knn_version()
    clear;
    load train_mean_vector;

    tt = squeeze(TrainMatrix)';
    nums = int16(size(TrainMatrix, 3) * 0.9);


    [classifierX, classifierY, predictData, realY] = randomSplit(tt, nums, TrainY');

    % classifierX = TrainMatrix(:, :, 1:nums);
    % classifierX = squeeze(classifierX)';
    % classifierY = TrainY(:, 1:nums)';
    % 
    % predictData = TrainMatrix(:, :, nums + 1:size(TrainMatrix, 3));
    % predictData = squeeze(predictData)';
    % realY = TrainY(:, nums + 1:size(TrainY, 2))';
    % 
    % predictFilesNum = size(predictData, 1);
    predictY = zeros(1, size(predictData, 1) );

    classifier = fitcknn(classifierX, classifierY, 'NumNeighbors', 3);

    r1 = ones(1, 10);
    r2 = ones(1, 10);
    up_k = 5;
    % for i = 3:up_k
    %     classifier.NumNeighbors = i;
    %     rloss = resubLoss(classifier);
    %     r1(1, i) = rloss;
    %     cvmdl = crossval(classifier);
    %     kloss = kfoldLoss(cvmdl);
    %     r2(1, i) = kloss;
    % end
    % 
    % [v, i1] = min(r1);
    % [v, i2] = min(r2);
    % fprintf('%d %d\n', i1, i1);
    accuracies = zeros(10, 1);
    for j = 1 : up_k
        classifier.NumNeighbors = j;
        for k = 1 : 1
            for i = 1:size(predictData, 1)
                predictY(1, i) = predict(classifier, predictData(i, :));
            end

            accuracy = sum(predictY' == realY) / length(predictData);
            accuracies(j) = accuracies(j) + accuracy;
        end
    end
% end