function optimise_momentum_constant( x, y, params)
%OPTIMISE_MIN_GRAD Optimises the momentum constant parameter
    possible_values = 0.1:0.1:1;
    three_fold_optimise(x, y, possible_values, params, 'mc');
end

