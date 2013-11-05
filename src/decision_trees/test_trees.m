

function [predictions] = test_trees(ts, examples)
%TESTTREES Given some trees and some examples returns a prediction for 
%each example using the trees.
    predictions = [];
    for i = 1:length(examples),
        example = examples(i,:);
        labels = [];
        depths = [];
        for t = ts,
           [labels(end+1), depths(end+1)] = test_tree(t{1}, example); 
        end
        predictions(i) = choose_label(labels, depths);  
    end
end

function [label, depth] = test_tree(t, example)
    if isempty(t.kids)
        label = t.class;
        depth = 1;
        return
    else
        kid = example(t.op) + 1;
        [label, depth] = test_tree(t.kids{kid}, example);
        depth = depth + 1;
    end
end

function [label] = choose_label(labels, depths)
    label = first_label(labels);
    %label = random_label(labels);
    %label = depth_weighted_label(labels, depths);
end

function [label] = first_label(labels)
    [~, label] = max(labels);
end

function [label] = random_label(labels)
    indices = find(labels);
    if isempty(indices)
        label = floor(rand(1)*length(labels)) + 1;
    else
        random = floor(rand(1)*length(indices)) + 1;
        label = indices(random);
    end
end

function [label] = depth_weighted_label(labels, depths)
    indices = find(labels);
    if isempty(indices)
        max_depth = max(depths);
        
        correct_indices = [];
        for i = 1:length(depths),
           if depths(i) == max_depth
               correct_indices(end + 1) = i;
           end
        end
        
        label = correct_indices(floor(rand(1)*length(correct_indices)) + 1);
    else
        min_depth = min(depths(labels==1));
        
        correct_indices = [];
        for i = 1:length(depths),
           if depths(i) == min_depth && labels(i) == 1
               correct_indices(end + 1) = i;
           end
        end
        
        label = correct_indices(floor(rand(1)*length(correct_indices)) + 1);
    end
end