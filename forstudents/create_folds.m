function [x_folds, y_folds] = create_folds(n, x, y)
%CREATE_FOLDS create n folds form input

    x_folds = {};
    y_folds = {};
    
    bucket_size = fix(length(x) / n);
    
    for i = 0:9,
        x_folds{i+1} = x(i*bucket_size + 1:(i+1)*bucket_size, :);
        y_folds{i+1} = y(i*bucket_size + 1:(i+1)*bucket_size);
    end
end

