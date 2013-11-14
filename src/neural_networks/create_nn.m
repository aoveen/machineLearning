function [ net ] = create_nn( x, y, train_validation_boundary, params )
%CREATE_SIX_OUTPUT_NN Create a neural network with 6 outputs.
    [x, y] = ANNdata(x, y);
    
    
    hl = params('hidden_layers');
    layers = hl(1);
    nodes = hl(2);
    hiddenLayers = make_layers(nodes, layers);
    
    net = feedforwardnet(hiddenLayers);
    net = configure(net, x, y);
    net.divideFcn = 'divideind';
    net.divideParam.valInd = 1:train_validation_boundary;
    net.divideParam.trainInd = (train_validation_boundary + 1):size(x,2);
    net.trainFcn = params('trainFcn');
    
    for key = keys(params),
       if ~(strcmp(key{1}, 'trainFcn') || strcmp(key{1}, 'hidden_layers'))
           net.trainParam.(key{1}) = params(key{1});
       end
    end
    
    net = train(net, x, y, 'useParallel', 'yes', 'useGPU', 'yes');
end

function [result] = make_layers(x, n)
    [result] = repmat(x,1,n);
end