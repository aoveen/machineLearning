function [acase] = Case(aus, label)
    % label is optional
    if (~exist('label', 'var'))
        label = -1;
    end
    x = zeros(1, 45);
    x(aus) = 1;
    acase = struct('aus', aus, 'x', x, 'label', label);
end
