%% Shared AUs Measure
% Cases are considered similar if they share AUs.
function [cost] = shared_aus_measure(a, b)
    cost = -sum(a.x == b.x);
end

