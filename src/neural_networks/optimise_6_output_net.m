function [ params ] = optimise_6_output_net( X, y )
    [~, trainingX] = select_fold(X, 1, 10);
    [~, trainingY] = select_fold(y, 1, 10);
    
    params = containers.Map;
    params('show') = NaN;
    params('showCommandLine') = 0;
    params('showWindow') = 0;
    params('time') = inf;
    
    params('hidden_layers') = [1, 30];
    params('trainFcn') = 'trainlm';
    
    optimise_layers(trainingX, trainingY, params);
    hl = params('hidden_layers');
    layers = hl(1)
    nodes = hl(2)

    get_best_training_function(trainingX, trainingY, params);

     % Optimise function-specific parameters here
     if strcmp(params('trainFcn'), 'traingd')
         optimise_gd_params(trainingX, trainingY, params);
     elseif strcmp(params('trainFcn'), 'traingdm')
         optimise_gdm_params(trainingX, trainingY, params);
     elseif strcmp(params('trainFcn'), 'trainlm')
         optimise_lm_params(trainingX, trainingY, params);
     else
        return; 
     end
end
