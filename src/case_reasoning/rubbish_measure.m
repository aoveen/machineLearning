function [diff] = rubbish_measure(a, b)
    diff = abs(length(a.aus) - length(b.aus));
end

