function [ optimised_epochs ] = optimise_epochs( x, y, training_func_name)
%OPTIMISE_EPOCHS Optimises the epochs parameter
    possible_values = 10:1100;
    errors = zeros(1,max(possible_values) - min(possible_values) + 1);
    
    for i = possible_values,
       confusion = zeros(6);
       for j = 1:3
           [validationX, trainingX] = select_fold(x, j, 3);
           [validationY, trainingY] = select_fold(y, j, 3);
           
           dataX = vertcat(validationX, trainingX);
           dataY = vertcat(validationY, trainingY);

           net = create_nn(dataX,dataY,size(x,1) / 3,{'trainFcn' training_func_name 'epochs' i});
           predictions = testANN(net, validationX);
           confusion = confusion + calc_confusion_matrix(validationY, predictions);
       end
       confusion = confusion / 3;
       [~,~,~,error] = stats(confusion);
       errors(i - min(possible_values) + 1) = error;
    end
    
    [~, index] = min(errors);
    optimised_epochs = possible_values(index + 1);
end

