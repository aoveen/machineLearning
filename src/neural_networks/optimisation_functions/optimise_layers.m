function optimise_layers( x, y, params )
%OPTIMISE_LAYERS Optimises the the number of hidden layers.
    max_in_layer = 100;
    min_in_layer = 1;
    min_layers = 1;
    max_layers = 3;
    bucket_size = 10;
    
    node_num_buckets = min_in_layer:bucket_size:max_in_layer;
    [p, q] = meshgrid(min_layers:max_layers, node_num_buckets);
    possible_pairs = [p(:) q(:)]
    
    vector_three_fold_optimise(x, y, possible_pairs, params, 'hidden_layers');
    
    hl = params('hidden_layers');
    layers = hl(1)
    best_bucket = hl(2)
    
    possible_node_num = floor(best_bucket-bucket_size/2):1:ceil(best_bucket+bucket_size/2);
    [p, q] = meshgrid(layers, possible_node_num);
    possible_pairs = [p(:) q(:)]
    
    three_fold_optimise(x, y, possible_pairs, params, 'hidden_layers');
end

