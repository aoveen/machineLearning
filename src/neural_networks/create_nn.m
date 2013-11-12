function [ net ] = create_nn( x, y, train_validation_boundary, params )
%CREATE_SIX_OUTPUT_NN Create a neural network with 6 outputs.
    [x, y] = ANNdata(x, y);
    hidden_layers = 2;
    net = feedforwardnet(hidden_layers);
    net = configure(net, x, y);
    net.divideFcn = 'divideind';
    net.divideParam.valInd = 1:train_validation_boundary;
    net.divideParam.trainInd = (train_validation_boundary + 1):size(x,2);
    
    for i = 1:2:size(params),
       if strcmp(params{i}, 'trainFcn')
           net.trainFcn = params{i+1};
       elseif strcmp(params{i}, 'epochs')
           net.trainParam.epochs = params{i+1};
       end
    end
    net = train(net, x, y);
end

