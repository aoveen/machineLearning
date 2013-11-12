function [ net ] = create_nn( x, y, prams )
%CREATE_SIX_OUTPUT_NN Create a neural network with 6 outputs.
    [x, y] = ANNdata(x, y);
    hidden_layers = 5;
    epochs = 50;
    net = feedforwardnet(hidden_layers);
    net = configure(net, x, y);
    net.trainParam.epochs = epochs;
    net = train(net, x, y);
end

