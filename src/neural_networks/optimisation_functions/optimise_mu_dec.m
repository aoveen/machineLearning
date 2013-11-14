function optimise_mu_dec( x, y, params)
%OPTIMISE_MIN_GRAD Optimises the mu_dec parameter
    possible_values = 0.01:0.01:0.3;
    three_fold_optimise(x, y, possible_values, params, 'mu_dec');
end

