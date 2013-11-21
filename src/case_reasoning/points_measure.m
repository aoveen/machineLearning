function [cost] = points_measure(a, b)
    cost = -sum(a.x == b.x);
end

