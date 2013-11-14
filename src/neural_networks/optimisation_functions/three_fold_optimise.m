function three_fold_optimise(x, y, possible_values, params, param)
    errors = zeros(1,length(possible_values));
    
    for i = 1:length(possible_values),
       confusion = zeros(6);
       for j = 1:3
           [validationX, trainingX] = select_fold(x, j, 3);
           [validationY, trainingY] = select_fold(y, j, 3);
           
           dataX = vertcat(validationX, trainingX);
           dataY = vertcat(validationY, trainingY);

           params(param) = possible_values(i, :);
           net = create_nn(dataX,dataY,size(x,1) / 3, params);
           predictions = testANN(net, validationX);
           confusion = confusion + calc_confusion_matrix(validationY, predictions);
       end
       confusion = confusion / 3;
       [~,~,~,error] = stats(confusion);
       errors(i) = error;
       disp(sprintf('TEST %s -> %s = %f', param, mat2str(possible_values(i, :)), error));
    end
    
    [~, index] = min(errors);
    params(param) = possible_values(index, :);
end