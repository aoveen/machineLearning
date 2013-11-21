function [acase] = Case(aus, label)
    % label is optional
    if (~exist('label', 'var'))
        label = 0;
    end
    acase = struct('aus', aus, 'label', label);
end
