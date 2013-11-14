function optimise_mu( x, y, params)
%OPTIMISE_MIN_GRAD Optimises the mu parameter
    possible_values = 0:0.0001:0.01;
    three_fold_optimise(x, y, possible_values, params, 'mu');
end

