clear;

% load train_pca_sdc;
load test_pca_sdc;

test_number = length(YY);
nums = length(YY);

temp = zeros(nums, 1);
for i = 1 : nums
    temp(i) = i;
end

temp_y = ones(nums, 1);

[x1, ~, x2, ~] = randomSplit(temp, int16(nums * 0.9), temp_y);

for i = 1 : size(x1, 1)
    ii = (i-1) * 39 + 1;
    index = x1(i);
    TrainX(ii:ii + 38,:) = TestX(index:index + 38, :);
    TrainY(ii:ii+38,:) = TestY(index:index+38, :);
end

save_TestX = TestX;
save_TestY = TestY;
save_YY = YY;

for i = 1 : size(x2,1)
    index = x2(i);
    ii = (i-1) * 39 + 1;
    tempTestX(ii:ii + 38, :) = TestX(index:index+38, :);
    tempTestY(ii:ii + 38, :) = TestY(index:index+38, :);
    TempYY(i,1) = YY(index);
end

TestX = tempTestX;
TestY = tempTestY;
YY = TempYY;

components = numel(unique(TrainY));
% options = statset('MaxIter', 1000, 'Display', 'iter');
options = statset('MaxIter', 1000);
GMMmodel = fitgmdist(TrainX, components, 'Start', TrainY + 1, 'Options', options);

fprintf('Done Training\n');

result = cluster(GMMmodel, TestX);

finalResult = zeros(test_number, 1);

curIndex = 1;

test_number = length(YY);
while curIndex < test_number
    index = (curIndex - 1) * 39 + 1;
    temp = result(index : index + 39 - 1, :);
    finalResult(curIndex) = mode(temp) - 1;
    curIndex = curIndex + 1;
end

finalResult = finalResult(1:test_number,:);
accuracy = sum(finalResult == YY) / length(YY);
fprintf('%f\n', accuracy);
