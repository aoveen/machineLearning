function [ net ] = create_nn( x, y, params )
%CREATE_SIX_OUTPUT_NN Create a neural network with 6 outputs.
    [x, y] = ANNdata(x, y);
    hidden_layers = 2;
    net = feedforwardnet(hidden_layers);
    net = configure(net, x, y);
    for i = 1:2:size(params),
       if strcmp(params{i}, 'trainFcn')
           net.trainFcn = params{i+1};
       elseif strcmp(params{i}, 'epochs')
           net.trainParam.epochs = params{i+1};
       end
    end
    net = train(net, x, y);
end

