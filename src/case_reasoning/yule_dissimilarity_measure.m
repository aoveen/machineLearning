function [cost] = yule_dissimilarity_measure(a, b)
    n11 = sum( a.x &  b.x);
    n01 = sum(~a.x &  b.x);
    n10 = sum( a.x & ~b.x);
    n00 = sum(~a.x & ~b.x);
    cost = (2*n10*n01) / (n11*n00 + n10*n01);
end

