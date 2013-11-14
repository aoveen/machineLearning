function optimise_mu_max( x, y, params)
%OPTIMISE_MIN_GRAD Optimises the mu_max parameter
    possible_values = 1e9:1e8:1e11;
    three_fold_optimise(x, y, possible_values, params, 'mu_max');
end

