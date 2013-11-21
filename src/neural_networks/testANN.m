function [ predictions ] = testANN( nets, x )
%TESTANN Summary of this function goes here
%   Detailed explanation goes here
    [x, ~] = ANNdata(x, []);
    number_of_nets = length(nets);
    if number_of_nets == 1
        t = test_single_ann(nets, x);
    else
        t = test_multi_ann(nets, x);
    end
    predictions = NNout2labels(t);
end

function [ t ] = test_single_ann( net, x )
    t = sim(net, x);
end

function [ t ] = test_multi_ann( nets, x )
    c = cellfun(@(net) test_single_ann(net, x), nets, 'UniformOutput', false);
    t = c{1};
    for i = 2:6
        t = vertcat(t, c{i});
    end
end
