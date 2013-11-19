function [ config_map ] = config_map_builder( hidden_layers, trainFcn, epochs, goal, max_fail, min_grad, mu, mu_dec, mu_inc, mu_max, lr, mc )

config_map = containers.Map;
config_map('show') = NaN;
config_map('showCommandLine') = 0;
config_map('showWindow') = 0;
config_map('time') = inf;

config_map('hidden_layers') = hidden_layers;
config_map('trainFcn') = trainFcn;
config_map('epochs') = epochs;
config_map('goal') = goal;
config_map('max_fail') = max_fail;
config_map('min_grad') = min_grad;

if strcmp(trainFcn, 'trainlm')   
    config_map('mu') = mu;
    config_map('mu_dec') = mu_dec;
    config_map('mu_inc') = mu_inc;
    config_map('mu_max') = mu_max;
elseif strcmp(trainFcn, 'traingd')
    config_map('lr') = 0.01;
    
elseif strcmp(trainFcn, 'traingdm')
    config_map('lr') = lr;
    config_map('mc') = mc;
    
end

end

