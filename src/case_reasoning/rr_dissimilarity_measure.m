function [cost] = rr_dissimilarity_measure(a, b)
    n = length(a.x);
    a = sum(a.x &  b.x);
    cost = (n - a) / n;
end

