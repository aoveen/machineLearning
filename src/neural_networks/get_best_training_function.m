function [ func_name ] = get_best_training_function( x, y)
%GET_BEST_TRAINING_FUNCTION Returns the name of the training function that
%gives the best classification rate
    
    candidate_training_fcns = {'traingd' 'traingdm' 'trainlm'};
    init_value_set = zeros(1,size(candidate_training_fcns,2));
    classification_rates = containers.Map(candidate_training_fcns, init_value_set);
    
    for func = candidate_training_fcns,
        strFunc = func{1};
        confusion = zeros(6);
        for i = 1:3,
           [validationX, trainingX] = select_fold(x, i, 3);
           [validationY, trainingY] = select_fold(y, i, 3);
           
           dataX = vertcat(validationX, trainingX);
           dataY = vertcat(validationY, trainingY);
           
           net = create_nn(dataX, dataY, size(x,1) / 3, {'trainFcn' strFunc});
           predictions = testANN(net, validationX);
           confusion = confusion + calc_confusion_matrix(validationY, predictions); 
        end
        confusion = confusion / size(candidate_training_fcns,2);
        [~,~,~,err] = stats(confusion);
        classification_rates(strFunc) = 1 - err;
    end
    [~,index] = max(cell2mat(values(classification_rates)));
    keyset = keys(classification_rates);
    func_name = keyset{index};
end

