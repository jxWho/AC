% Training
clear;
load train;

NumTrainFiles = size(TrainMatrix, 3);
numOfCluster = 4;
maxRow = size(TrainMatrix(:,:,1), 1);
column = size(TrainMatrix(:,:,1), 2);
means = zeros(maxRow, column, numOfCluster);
meanIndexs = [-1, -1, -1, -1];
cnt = 0;
while cnt < numOfCluster
    i = -1;
    while 1
        i = randi(length(TrainY)) - 1;
        if (meanIndexs( TrainY(i) + 1 ) == -1 )
            break;
        end
    end
    if meanIndexs( TrainY(i) + 1 ) == -1
       meanIndexs( TrainY(i) + 1 ) = i;
       means(:,:,TrainY(i) + 1 ) = TrainMatrix(:,:, i);
       cnt = cnt + 1;
    end
end

classes = ones(1, NumTrainFiles) .* -1;

distArray = zeros(NumTrainFiles, numOfCluster);
iterCnt = 0;
while 1
    tic
    iterCnt = iterCnt + 1;
    fprintf('%d\n', iterCnt);
    % cluster
    savedClasses = classes;
    for i = 1 : numOfCluster
        tempMean = means(:, :, i);
        tempMean = repmat(tempMean, 1, 1, NumTrainFiles);
        dist = TrainMatrix - tempMean;
        dist = dist.*dist;
        dist = sum(sum(dist, 1), 2);
        dist = sqrt(dist);
        distArray(:,i) = dist(1, 1, :);
    end
    [M, I] = min(distArray, [], 2);
    I = I - ones(size(I,1), size(I, 2));
    I = I';
    classes = I;
    % update mean
    for i = 0 : numOfCluster - 1
        inClass_i = (classes == ones(size(classes, 1), size(classes,2)) * i);
        tempDataPoints = TrainMatrix(:, :, inClass_i);
        total = size(tempDataPoints, 3);
        tempDataPoints = sum(tempDataPoints, 3) ./ total ;
        means(:,:,i+1) = tempDataPoints;
    end
    if savedClasses == classes
        break
    end
    toc
end

fprintf('%f\n', sum(classes == TrainY)/NumTrainFiles);

fileID = fopen('TrainResult.txt', 'w');
for i = 1:length(classes)
    fprintf(fileID, '%d\n', classes(i));
end
