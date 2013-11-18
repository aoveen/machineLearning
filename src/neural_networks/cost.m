function [ cost ] = cost( raw_output, targets)
%COST Cost function to optimise parameters
%   Detailed explanation goes here
    combined = horzcat(raw_output, targets);
    cell_version = num2cell(combined, 2);
    cost = cellfun(@cost_single,cell_version);
end

function [cost] = cost_single(inputs)
    raw = inputs(1);
    target = logical(inputs(2));
    
    x = logsig(raw);
    
    if target == 1
        cost = -log(x);
    else
        cost = -log(1-x);
    end
end
