function three_fold_optimise(x, y, possible_values, params, param)
    errors = zeros(1,length(possible_values));
    
    for i = 1:length(possible_values),
       avg_total_cost = 0;
       for j = 1:3
           [validationX, trainingX] = select_fold(x, j, 3);
           [validationY, trainingY] = select_fold(y, j, 3);
           
           dataX = vertcat(validationX, trainingX);
           dataY = vertcat(validationY, trainingY);

           params(param) = possible_values(i);
           net = create_nn(dataX,dataY,floor(size(x,1) / 3), params);
           prediction_raw_values = sim(net, validationX');

           if size(prediction_raw_values,1) == 1
               c = cost(prediction_raw_values', validationY);
               avg_total_cost = avg_total_cost + sum(c);
           else
              [max_raw_values, predictions] = max(prediction_raw_values);
              binary_targets = predictions' == validationY;
              c = cost(max_raw_values',binary_targets);
              avg_total_cost = avg_total_cost + sum(c);
           end
       end
       avg_total_cost = avg_total_cost / 3;
       errors(i) = avg_total_cost;
       disp(sprintf('TEST %s -> %s = %f', param, mat2str(possible_values(i, :)), avg_total_cost));
    end
    
    [~, index] = min(errors);
    params(param) = possible_values(index);
end