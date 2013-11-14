function optimise_mu_inc( x, y, params)
%OPTIMISE_MIN_GRAD Optimises the mu_inc parameter
    possible_values = 1:20;
    three_fold_optimise(x, y, possible_values, params, 'mu_inc');
end

