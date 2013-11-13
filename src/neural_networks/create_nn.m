function [ net ] = create_nn( x, y, train_validation_boundary, params )
%CREATE_SIX_OUTPUT_NN Create a neural network with 6 outputs.
    [x, y] = ANNdata(x, y);
    hidden_layers = 2;
    net = feedforwardnet(hidden_layers);
    net = configure(net, x, y);
    net.divideFcn = 'divideind';
    net.divideParam.valInd = 1:train_validation_boundary;
    net.divideParam.trainInd = (train_validation_boundary + 1):size(x,2);
    net.trainFcn = params('trainFcn');
    
    for key = keys(params),
       if strcmp(key{1}, 'epochs')
           net.trainParam.epochs = params(key{1});
       elseif strcmp(key{1}, 'goal')
           net.trainParam.goal = params(key{1});
       elseif strcmp(key{1}, 'max_fail')
           net.trainParam.max_fail = params(key{1});
       elseif strcmp(key{1}, 'min_grad')
           net.trainParam.min_grad = params(key{1});
       elseif strcmp(key{1}, 'show')
           net.trainParam.show = params(key{1});
       elseif strcmp(key{1}, 'showCommandLine')
           net.trainParam.showCommandLine = params(key{1});
       elseif strcmp(key{1}, 'showWindow')
           net.trainParam.showWindow = params(key{1});
       elseif strcmp(key{1}, 'time')
           net.trainParam.time = params(key{1});
       end
    end
    
    net = train(net, x, y, 'useParallel', 'yes', 'useGPU', 'yes');
end

