function [ cost ] = euclidean_distance_measure ( a, b )

    diff = a.x - b.x;
    square = diff.^2;
    square_sum = sum(square);
    cost = sqrt(square_sum);
    
end

