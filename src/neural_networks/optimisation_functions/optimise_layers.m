function optimise_layers( x, y, params )
%OPTIMISE_LAYERS Optimises the the number of hidden layers.
    max_in_layer = 10;
    min_in_layer = 1;
    bucket_size = 5;
    
    possible_values = min_in_layer:bucket_size:max_in_layer;
    three_fold_optimise(x, y, possible_values, params, 'hiddenSizes');
    
    best_bucket = params('hiddenSizes');
    possible_values = floor(best_bucket-bucket_size/2):1:ceil(best_bucket+bucket_size/2);
    three_fold_optimise(x, y, possible_values, params, 'hiddenSizes');
end

