function [cost] = matching_dissimilarity_measure(a, b)
    cost = sum((a.x ~= b.x)) / length(a.x);
end

