function [ nets ] = create_six_one_output_nn( x, y, hidden_layers )
    nets = cell(6);
    for i = 1:6
        nets(i) = create_nn(x, y(i, :), hidden_layers);
    end
end

