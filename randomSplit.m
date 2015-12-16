function [ x1, y1, x2, y2 ] = randomSplit( x, nums, y )
    numOfX = size(x, 1);
    mark = zeros(numOfX, 1);
    x1 = zeros(nums, size(x, 2));
    x2 = zeros(numOfX - nums, size(x, 2));
    y1 = zeros(nums, size(y,2));
    y2 = zeros(numOfX - nums, size(y, 2));
    
    cnt = 0;
    while cnt < nums
        while 1
            t = randi(numOfX);
            if mark(t) == 0
                mark(t) = 1;
                cnt = cnt + 1;
                x1(cnt, :) = x(t, :);
                y1(cnt, :) = y(t, :);
                break;
            end
        end
    end

    cnt = 0;
    for i = 1 : numOfX
        if mark(i) == 0
            cnt = cnt + 1;
            x2(cnt, :) = x(i, :);
            y2(cnt, :) = y(i, :);
        end
    end
end
