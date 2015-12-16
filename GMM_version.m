clear;

% load train_mean_vector;
load train_pca_mean_vector;

nums = int16(size(TrainMatrix, 3) * 0.6);
tt = squeeze(TrainMatrix)';
[classifierX, classifierY, predictData, realY] = randomSplit(tt, nums, TrainY');
classifierY = classifierY + 1;
realY = realY + 1;

components = numel(unique(classifierY));

options = statset('MaxIter', 5000);
% GMModels = cell(components, 1);

GMMmodel = fitgmdist(classifierX, components, 'Start', classifierY, 'Options', options);

result = GMMmodel.cluster(predictData);

% for i = 1 : components
%     x = classifierX(classifierY == ones(size(classifierY, 1), 1) * i, :);
%     size(x, 1)
%     y = ones(size(x, 1), 1) * i;
%     GMModels{i} = fitgmdist(x, 1, 'Options', options);
% end
% 
% for j = 1 : components
%     score(:, i) = GMModels{i}.posterior(predictData);
% end
% [~, result] = max(score, [], 2);
 accuracy = sum(result == realY) / length(realY);

 fprintf('%f\n', accuracy);