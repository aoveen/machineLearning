function main
    load('forstudents/cleandata_students.mat')
    %test_split();
    %return
    x = x(1:100, :);
    y = y(1:100);
    
    for n = 1:6,
        targets = binary_filter(y, n);
        attributes = 1:size(x, 2);
        tree = decision_tree_learning(x, attributes, targets);
        DrawDecisionTree(tree, 'Tree')
        % display(n)
    end
end

function [ targets ] = binary_filter( labels, target_label );
    targets = double(labels == target_label);
end

function [ decision_tree ] = decision_tree_learning( examples, attributes, binary_targets )
    if all(binary_targets == binary_targets(1))
       decision_tree.class = binary_targets(1);
       decision_tree.kids  = [];
    elseif isempty(attributes)
        decision_tree.class = 66;%mode(binary_targets);
        decision_tree.kids = [];
    else
        best_attribute = choose_best_decision_attribute(examples, attributes, binary_targets);
        tree.op = best_attribute;
        tree.kids = cell(1, 2);
        for value = 0:1,            
            [new_examples, new_binary_targets] = split_examples_targets(examples, binary_targets, best_attribute, value);
            if (isempty(new_examples))
                decision_tree.class = mode(binary_targets);
                decision_tree.kids = [];
                return
            else
                new_attributes = attributes(attributes~=best_attribute);
                subtree = decision_tree_learning( new_examples, new_attributes, new_binary_targets);
                tree.kids{value+1} = subtree;
            end
        end
        decision_tree = tree;
    end    
end

function [best_attribute] = choose_best_decision_attribute(examples, attributes, binary_targets)
    remainders = arrayfun(@(x) remainder(x, examples, binary_targets), attributes);
    [~, index] = min(remainders);
    best_attribute = attributes(index);
end

function [information_gain] = gain(attribute, examples, binary_targets)    
    pos = sum(binany_targets == 1);
    neg = sum(binary_targets == 0);
    information_gain = information(pos, neg) - remainder(attribute, examples, binary_targets);    
end

function [i] = information(pos, neg)
    total = pos + neg;
    i = -(pos/total)*log2(pos/total) -(neg/total)*log2(neg/total);
end

function [remainder] = remainder(attribute, examples, binary_targets)
    total = length(examples);
    [~, zero_targets] = split_examples_targets(examples, binary_targets, attribute, 0);
    [~, one_targets] = split_examples_targets(examples, binary_targets, attribute, 1);
    pos0 = sum(zero_targets == 1);
    neg0 = sum(zero_targets == 0);
    pos1 = sum(one_targets == 1);
    neg1 = sum(one_targets == 0);
    remainder = ((pos0 + neg0)/total)*information(pos0, neg0) + ((pos1 + neg1)/total)*information(pos1, neg1);
end

function [ new_examples, new_binary_targets ] = split_examples_targets(examples, binary_targets, attribute, value )
    attr_column = examples(:,attribute);
    rows_to_keep = attr_column == value;
    new_examples = examples;
    new_examples(~rows_to_keep, :) = [];
    new_binary_targets = binary_targets;
    new_binary_targets(~rows_to_keep, :) = [];
end

function test_split
    examples = [0 0; 1 0; 1 0];
    targets = [1; 0; 1];
    attribute = 1;
    value = 0;
    [ex, bin] = split_examples_targets(examples, targets, attribute, value);
    display(ex);
    display(bin);
end
