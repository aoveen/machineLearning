function optimise_gd_params( x, y, param_values)
%OPTIMISE_GD_PARAMS Optimise function parameters for gd function
    display('trainFcn');
    param_values('trainFcn')

    optimise_epochs(x, y, param_values);
    display('epochs');
    param_values('epochs')

    optimise_goal(x, y, param_values);
    display('goal');
    param_values('goal')

    optimise_learning_rate(x, y, param_values);
    display('learning rate');
    param_values('lr')
    
    optimise_max_fail(x, y, param_values);
    display('max_fail');
    param_values('max_fail')

    optimise_min_grad(x, y, param_values);
    display('min_grad');
    param_values('min_grad')
end