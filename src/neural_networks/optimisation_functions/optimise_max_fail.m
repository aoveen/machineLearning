function optimise_max_fail( x, y, params)
%OPTIMISE_MAX_FAIL Optimises the max_fail parameters
    possible_values = 1:10;
    three_fold_optimise(x, y, possible_values, params, 'max_fail');
end

