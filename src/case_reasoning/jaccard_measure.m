function [cost] = jaccard_measure(a, b)
    cost = 1 - (sum(a.x & b.x) / sum(a.x | b.x));
end

