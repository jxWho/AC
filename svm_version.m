clear;

load train_mean_vector;
% addpath('./multisvm');

nums = int16(size(TrainMatrix, 3) * 0.9);
tt = squeeze(TrainMatrix)';
[classifierX, classifierY, predictData, realY] = randomSplit(tt, nums, TrainY');
classifierY = zeros(size(classifierY, 1), size(classifierY, 2)) ~= classifierY;
realY = zeros(size(realY, 1), size(realY, 2)) ~= realY;


result = zeros(length(predictData),1);

options = optimset('MaxIter', 30000);
% model = svmtrain(classifierX, classifierY, 'options', options, 'kernel_function', 'polynomial');
model = fitcsvm(classifierX, classifierY,'Standardize',true,'KernelFunction','RBF',...
    'KernelScale','auto', 'OutlierFraction',0.05);
% for i = 1 : size(predictData, 1)
% %     if(svmclassify(model, predictData(i,:)) )
% %         result(i) = 0;
% %     else
% %         result(i) = 1;
% %     end
%     result(i) = predict(model, predictData(i, :));
% end
result = predict(model, predictData);
%result = multisvm(classifierX, classifierY, predictData);
accuracy = sum(result == realY) / length(predictData);
fprintf('%f\n', accuracy); 

