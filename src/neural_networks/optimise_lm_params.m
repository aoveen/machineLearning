function [ param_values ] = optimise_lm_params( x, y )
%OPTIMISE_LM_PARAMS Optimises the parameters for the lm training function
    %param_funcs = [@epochs, @goal, @max_fail, @min_grad, @mu, @mu_dec, @mu_inc, @mu_max];
    
    param_values = containers.Map;
    %optimised_epochs = optimise_epochs(x, y, 'trainlm');
    %param_values('epochs') = optimised_epochs;
    
    optimised_goal = optimise_goal(x, y, 'trainlm');
    param_values('goal') = optimised_goal;
end

