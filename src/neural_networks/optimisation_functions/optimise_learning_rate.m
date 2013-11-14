function optimise_learning_rate( x, y, params)
%OPTIMISE_MIN_GRAD Optimises the learning rate parameter
    possible_values = 0.001:0.001:0.1;
    three_fold_optimise(x, y, possible_values, params, 'lr');
end

