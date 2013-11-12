function [ prams, confusion ] = train_a_single_net( X, y )
    [~, trainingX] = select_fold(X, 1, 10);
    [~, trainingY] = select_fold(y, 1, 10);
    
    % Paul and Simon's amazing, awesome spectacular function goes here!
    % prams = select_prams(trainingX, trainingY);
    prams = {};
    
    best_function = get_best_training_function(trainingX, trainingY);

    parameter_values = containers.Map;
    if strcmp(best_function, 'traingd')
        parameter_values = optimise_gd_params(trainingX, trainingY);
    elseif strcmp(best_function, 'traingdm')
        parameter_values = optimise_gdm_params(trainingX, trainingY);
    elseif strcmp(best_function, 'trainlm')
        parameter_values = optimise_lm_params(trainingX, trainingY);
    else
       return; 
    end
    parameter_values
    
    return

    confusion = zeros(6);
    for i = 1:10
        [testX, trainingX] = select_fold(X, i, 10);
        [testY, trainingY] = select_fold(y, i, 10);
        net = create_nn(trainingX, trainingY, prams);
        predictions = testANN(net, testX);
        confusion = confusion + calc_confusion_matrix(testY, predictions); 
    end
end

