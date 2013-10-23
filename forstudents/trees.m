function main
    load('forstudents/cleandata_students.mat')
    for n = 1:6,
        targets = binary_filter(y, n);
        attributes = 1:size(x, 2);
        tree = decision_tree_learning(x, attributes, targets);
        DrawDecisionTree(tree, 'Tree')
        % display(n)
    end
end

function [ targets ] = binary_filter( labels, target_label );
    %targets = zeros(length(labels), 1)
    targets = arrayfun(@(x) x == target_label, labels);
end

function [ decision_tree ] = decision_tree_learning( examples, attributes, binary_targets )
    if all(binary_targets == binary_targets(1))
       decision_tree.class = binary_targets(1);
       decision_tree.kids  = [];
    elseif isempty(attributes)
        decision_tree.class = mode(binary_targets);
        decision_tree.kids = [];
    else
        %best_attribute = choose_best_decision_attribute(examples, attributes, binary_targets);
        %tree.op = best_attribute;
        
        for x = 0:1,
         %   new_examples
            
         %   tree.kids(x + 1) = subtree;
        end
    end
    
    


    decision_tree.op = 3;
    left.class = 1;
    left.kids = [];
    
    right.class = 0;
    right.kids = [];
    
    decision_tree.kids = {left right};
    display(decision_tree)
end

function [ new_examples, new_binary_targets ] = split_examples_targets(examples, binary_targets, attribute, value )
    attr_column = examples(:,attribute)
    rows_to_keep = attr_column == value
    new_examples = examples
    new_examples(~rows_to_keep, :) = [];
    new_binary_targets = binary_targets;
    new_binary_targets(~rows_to_keep, :) = [];
end

function test_split
    examples = [0 0; 1  0];
    targets = [1; 0];
    attribute = 1;
    value = 1;
    [ex, bin] = split_examples_targets(examples, targets, attribute, value);
    display(ex);
    display(bin);
    
end
