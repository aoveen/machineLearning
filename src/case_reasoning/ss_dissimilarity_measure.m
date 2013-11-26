function [cost] = ss_dissimilarity_measure(a, b)
    x = sum(a.x ~= b.x);
    a = sum(a.x & b.x);
    cost = (2*x) / (a + 2*x);
end

