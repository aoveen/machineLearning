function [ optimised_epochs ] = optimise_epochs( x, y, training_func_name)
%OPTIMISE_EPOCHS Optimises the epochs parameter

    possible_values = 1:5000;
    errors = zeros(1,5000);
    
    for i = possible_values,
       confusion = zeros(6);
       i
       for j = 1:3
           [validationX, trainingX] = select_fold(x, j, 3);
           [validationY, trainingY] = select_fold(y, j, 3);

           net = create_nn(trainingX,trainingY,{'trainFcn' training_func_name 'epochs' i});
           predictions = testANN(net, validationX);
           confusion = confusion + calc_confusion_matrix(validationY, predictions);
       end
       confusion = confusion / 3;
       [~,~,~,error] = stats(confusion);
       errors(i) = error;
    end
    
    [~, optimised_epochs] = min(current_epochs);
end

