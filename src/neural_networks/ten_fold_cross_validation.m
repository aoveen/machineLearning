function [x1s, y1s] = ten_fold_cross_validation(x, y)
    [xs, ys] = create_folds(10, x, y);
    x1s = {}; 
    y1s = {}; 
    for i = 1:length(xs)
        [x1, y1] = ANNdata(xs{i}, ys{i});
        x1s{i} = x1;
        y1s{i} = y1;
    end
    for i = 1:10
        
    end
    x1s
    y1s
    result = x1s;
end

