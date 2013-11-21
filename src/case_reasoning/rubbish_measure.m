%% Rubbish Measure
% Cases are considered similar if the number of AUs they have are
% similar...
function [diff] = rubbish_measure(a, b)
    diff = abs(length(a.aus) - length(b.aus));
end

