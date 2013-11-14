function optimise_lm_params( x, y, param_values )
%OPTIMISE_LM_PARAMS Optimises the parameters for the lm training function
    display('trainFcn');
    param_values('trainFcn')

    optimise_epochs(x, y, param_values);
    display('epochs');
    param_values('epochs')

    optimise_goal(x, y, param_values);
    display('goal');
    param_values('goal')

    optimise_max_fail(x, y, param_values);
    display('max_fail');
    param_values('max_fail')

    optimise_min_grad(x, y, param_values);
    display('min_grad');
    param_values('min_grad')
    
    optimise_mu(x, y, param_values);
    display('mu');
    param_values('mu')
    
    optimise_mu_dec(x, y, param_values);
    display('mu_dec');
    param_values('mu_dec')
    
    optimise_mu_inc(x, y, param_values);
    display('mu_inc');
    param_values('mu_inc')
    
    optimise_mu_max(x, y, param_values);
    display('mu_max');
    param_values('mu_max')
end

