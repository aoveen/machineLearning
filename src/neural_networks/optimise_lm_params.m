function optimise_lm_params( x, y, param_values )
%OPTIMISE_LM_PARAMS Optimises the parameters for the lm training function
    %param_funcs = [@epochs, @goal, @max_fail, @min_grad, @mu, @mu_dec, @mu_inc, @mu_max];
    
    param_values('trainFcn')
    %optimise_epochs(x, y, 'trainlm', param_values);
    %param_values('epochs')

    %optimise_goal(x, y, param_values);
    %param_values('goal')

    optimise_max_fail(x, y, param_values);
    param_values('max_fail')

    optimise_min_grad(x, y, param_values);
    param_values('min_grad')
end

