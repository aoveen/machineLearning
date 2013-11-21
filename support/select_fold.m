function [selected_fold, other_folds] = select_fold(data, selected, n)

    other_folds = [];
    selected_fold = [];
    
    bucket_size = fix(length(data) / n);
    
    for i = 0:n-1,
        if (i+1 == selected),
            selected_fold = data(i*bucket_size + 1:(i+1)*bucket_size, :);
        else
            other_folds = vertcat(other_folds, data(i*bucket_size + 1:(i+1)*bucket_size, :));
        end
    end
end

