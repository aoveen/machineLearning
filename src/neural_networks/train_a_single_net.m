function [ prams, confusion ] = train_a_single_net( X, y )
    [~, trainingX] = select_fold(X, 1, 10);
    [~, trainingY] = select_fold(y, 1, 10);
    
    % Paul and Simon's amazing, awesome spectacular function goes here!
    % prams = select_prams(trainingX, trainingY);
    
    params = containers.Map;
    params('show') = NaN;
    params('showCommandLine') = 0;
    params('showWindow') = 1;
    params('time') = inf;
    
    get_best_training_function(trainingX, trainingY, params);
    % Optimise some general parameters here
    
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
    params
    
    return

    confusion = zeros(6);
    for i = 1:10
        [testX, trainingX] = select_fold(X, i, 10);
        [testY, trainingY] = select_fold(y, i, 10);
        net = create_nn(trainingX, trainingY, 100, params);
        predictions = testANN(net, testX);
        confusion = confusion + calc_confusion_matrix(testY, predictions); 
    end
end

