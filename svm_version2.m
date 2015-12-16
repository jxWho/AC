clear;

load train_mean_vector;

nums = int16(size(TrainMatrix, 3) * 0.7);
tt = squeeze(TrainMatrix)';
[classifierX, classifierY, predictData, realY] = randomSplit(tt, nums, TrainY');

classes = unique(classifierY);
SVMmodels = cell(numel(classes), 1);

for j = 1 : numel(classes)
    len = numel(classifierY);
    temp = ones(len, 1) * classes(j);
    indx = (classifierY == temp);
    SVMmodels{j} = fitcsvm(classifierX, indx, 'ClassNames',[false true], ...
        'Standardize',true,...
        'KernelFunction','rbf','BoxConstraint',1, 'KernelScale','auto');
end

N = size(predictData, 1);
Scores = zeros(N, numel(classes));

for j = 1 : numel(classes)
    [~, score] = predict(SVMmodels{j}, predictData);
    Scores(:, j) = score(:, 2); % Second column(y == 1) contains positive-class scores
end
[~, result] = max(Scores, [], 2);
result = result - 1;
accuracy = sum((result == realY)) / numel(realY);
fprintf('%f\n', accuracy);