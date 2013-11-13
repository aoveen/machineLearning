function optimise_epochs( x, y, params)
%OPTIMISE_EPOCHS Optimises the epochs parameter
    possible_values = 10:1100;
    three_fold_optimise(x, y, possible_values, params, 'epochs');
end
