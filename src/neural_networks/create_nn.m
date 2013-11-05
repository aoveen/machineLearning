function [ net ] = create_nn( x, y, hidden_layers, epochs )
%CREATE_SIX_OUTPUT_NN Create a neural network with 6 outputs.

    net = feedforwardnet(hidden_layers);
    net = configure(net, x, y);
    net.trainParam.epochs = epochs;
    net = train(net, x, y);
end

