function [ optimised_goal ] = optimise_goal( x, y, training_func_name )
%OPTIMISE_GOAL Optimises the performance goal
    possible_values = 0:0.01:1;
    errors = zeros(1,(max(possible_values) - min(possible_values)) / 0.01 + 1);
    possible_values
    errors
    
    for i = possible_values,
       confusion = zeros(6);
       for j = 1:3
           [validationX, trainingX] = select_fold(x, j, 3);
           [validationY, trainingY] = select_fold(y, j, 3);
           
           dataX = vertcat(validationX, trainingX);
           dataY = vertcat(validationY, trainingY);

           net = create_nn(dataX,dataY,size(x,1) / 3,{'trainFcn' training_func_name 'goal' i});
           predictions = testANN(net, validationX);
           confusion = confusion + calc_confusion_matrix(validationY, predictions);
       end
       confusion = confusion / 3;
       [~,~,~,error] = stats(confusion);
       
       errors(floor(i / 0.01) + 1) = error;
    end
    
    [~, index] = min(errors);
    errors
    optimised_goal = possible_values(index + 1)
end

