function optimise_goal( x, y, params )
%OPTIMISE_GOAL Optimises the performance goal
    possible_values = 0:0.0001:0.001;
    three_fold_optimise(x, y, possible_values, params, 'goal');
end

