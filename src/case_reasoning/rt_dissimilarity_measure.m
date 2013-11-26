function [cost] = rt_dissimilarity_measure(a, b)
    x = sum(a.x ~= b.x);
    e = sum(a.x ==  b.x);
    cost = 2*x / (e + 2*x);
end

