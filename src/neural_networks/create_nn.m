function [ net ] = create_nn( x, y, train_validation_boundary, params )
%CREATE_SIX_OUTPUT_NN Create a neural network with 6 outputs.
    % if we want a single output network we pass in a vector of 0/1s, so we
    % don't need ANNdata
    % HACK alarm!
    if sum(y==6) > 0
        [x, y] = ANNdata(x, y);
    else
        x = x';
        y = y';
    end
    
    
    hl = params('hidden_layers');
    layers = hl(1);
    nodes = hl(2);
    hiddenLayers = make_layers(nodes, layers);
    
    net = feedforwardnet(hiddenLayers);
    net = configure(net, x, y);
    if train_validation_boundary == -1
        net.divideFcn = 'dividerand';
        net.divideParam.trainRatio = 8/9;
        net.divideParam.valRatio = 1/9;
        net.divideParam.testRatio = 0.0;
    else
        net.divideFcn = 'divideind';
        net.divideParam.valInd = 1:train_validation_boundary;
        net.divideParam.trainInd = (train_validation_boundary + 1):size(x,2);
    end
    
    net.trainFcn = params('trainFcn');
    
    for i = 1:layers
       net.layers{i}.transferFcn = params('transferFcn'); 
    end

    
    for key = keys(params),
       if ~(strcmp(key{1}, 'trainFcn') || strcmp(key{1}, 'hidden_layers') || strcmp(key{1}, 'transferFcn'))
           net.trainParam.(key{1}) = params(key{1});
       end
    end
    
    net = train(net, x, y);
end

function [result] = make_layers(x, n)
    [result] = repmat(x,1,n);
end
