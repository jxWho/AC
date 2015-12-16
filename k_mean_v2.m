% Training
clear;
load train;
numOfCluster = 4;
maxRow = size(TrainMatrix(:,:,1), 1);
column = size(TrainMatrix(:,:,1), 2);
means = zeros(numOfCluster, 39);
meanIndexs = [-1, -1, -1, -1];

TrainMatrix = sum(TrainMatrix, 1);
TrainMatrix = squeeze(TrainMatrix);
TrainMatrix = TrainMatrix';

for i = 1 : length(TrainY)
    if meanIndexs( TrainY(i) + 1 ) == -1
       meanIndexs( TrainY(i) + 1 ) = i;
       means(TrainY(i) + 1, : ) = TrainMatrix(i, :);
    end
end

classes = zeros(1, NumTrainFiles);

distArray = zeros(NumTrainFiles, numOfCluster);
iterCnt = 0;
while 1
    tic
    iterCnt = iterCnt + 1
    % cluster
    savedClasses = classes;
    for i = 1 : numOfCluster
        tempMean = means(i, : );
        tempMean = repmat(tempMean, NumTrainFiles, 1);
        dist = TrainMatrix - tempMean;
        dist = dist.*dist;
%         dist = sum(sum(dist, 1), 2);
        dist = sum(dist, 2);
        distArray(:,i) = dist;
    end
    [M, I] = min(distArray, [], 2);
    I = I - ones(size(I,1), size(I, 2));
    I = I';
    classes = I;
    % update mean
    for i = 0 : numOfCluster - 1
        inClass_i = (classes == ones(size(classes, 1), size(classes,2)) * i);
        tempDataPoints = TrainMatrix.*repmat(inClass_i', 1, 39);
        total = size(tempDataPoints, 1);
        tempDataPoints = sum(tempDataPoints, 1) ./ total ;
        means(i+1, : ) = tempDataPoints;
    end
    if savedClasses == classes
        break
    end
    toc
end
