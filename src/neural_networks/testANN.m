function [ predictions ] = testANN( nets, x )
%TESTANN Summary of this function goes here
%   Detailed explanation goes here
    number_of_nets = length(nets);
    if number_of_nets == 1
        t = test_single_ann(nets, x);
    else
        t = test_multi_ann(nets, x);
    end
    predictions = NNout2labels(t); %NNout2lables(t);
end

function [ t ] = test_single_ann( net, x )
    t = sim(net, x);
end

function [ t ] = test_multi_ann( nets, x )
    t = arrayfun(@(net) test_single_ann(net, x), nets);
    % Select only one 
end
