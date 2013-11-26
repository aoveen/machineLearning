function [cost] = dice_dissimilarity_measure(a, b)
    n = sum(a.x ~= b.x);
    cost = n / (2*sum(a.x & b.x) + n);
end

