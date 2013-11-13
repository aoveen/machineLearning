function optimise_min_grad( x, y, params)
%OPTIMISE_MIN_GRAD Optimises the min_grad parameter
%   Detailed explanation goes here
    possible_values = 0:1e-8:1e-6;
    three_fold_optimise(x, y, possible_values, params, 'min_grad');
end

