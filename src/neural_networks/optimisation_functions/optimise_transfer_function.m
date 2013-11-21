function optimise_transfer_function( x, y, params)
%OPTIMISE_TRANSFER_FUNCTION Optimises the transfer function
    candidate_transfer_fcns = {'tansig' 'logsig'};
    init_value_set = zeros(1,size(candidate_transfer_fcns,2));
    classification_rates = containers.Map(candidate_transfer_fcns, init_value_set);
    
    for func = candidate_transfer_fcns,
        strFunc = func{1};
        avg_total_cost = 0;
        for i = 1:3,
           [validationX, trainingX] = select_fold(x, i, 3);
           [validationY, trainingY] = select_fold(y, i, 3);
           
           dataX = vertcat(validationX, trainingX);
           dataY = vertcat(validationY, trainingY);
           
           params('transferFcn') = strFunc;
           
           net = create_nn(dataX, dataY, floor(size(x,1) / 3), params);
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
        classification_rates(strFunc) = 1 - avg_total_cost;
    end
    [~,index] = max(cell2mat(values(classification_rates)));
    keyset = keys(classification_rates);
    params('transferFcn') = keyset{index};
end

