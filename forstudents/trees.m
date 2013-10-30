% function funs = trees
%   funs.main = @main;
%   funs.binary_filter = @binary_filter;
%   funs.decision_tree_learning = @decision_tree_learning;
%   funs.choose_best_decision_attribute = @choose_best_decision_attribute;
%   funs.gain = @gain;
%   funs.information = @information;
%   funs.remainder = @remainder;
%   funs.split_examples_targets = @split_examples_targets;
% end

function main
    load('forstudents/cleandata_students.mat')
    
    ten_fold_data_x = {};
    ten_fold_data_y = {};
    
    bucket_size = fix(length(x) / 10);
    
    for i = 0:9,
        ten_fold_data_x{i+1} = x(i*bucket_size + 1:(i+1)*bucket_size, :);
        ten_fold_data_y{i+1} = y(i*bucket_size + 1:(i+1)*bucket_size);
    end
    confusion = zeros(6, 6);
    for i = 1:10,
        test_set_x = ten_fold_data_x{i};
        test_set_y = ten_fold_data_y{i};
        
        training_data_x = []; 
        training_data_y = [];
        
        for j = 1:10,
           if (j ~= i),
              training_data_x = vertcat(training_data_x, ten_fold_data_x{j});
              training_data_y = vertcat(training_data_y, ten_fold_data_y{j}); 
           end
        end
        trees = {};
        for n = 1:6,
            targets = binary_filter(training_data_y, n);
            attributes = 1:size(training_data_x, 2);
            tree = decision_tree_learning(training_data_x, attributes, targets);
            trees{n} = tree;
            %DrawDecisionTree(tree, 'Tree')
        end
        predictions = testTrees(trees, test_set_x);
        confusion = confusion + confuse(test_set_y, predictions);
        confusion
    end
    confusion
end

function [confusion] = confuse(actual, predictions)
    confusion = zeros(6, 6);
    for i = 1:length(actual),
        confusion(actual(i), predictions(i)) = confusion(actual(i), predictions(i)) + 1;
    end
end

function [predictions] = testTrees(ts, examples)
    predictions = [];
    for i = 1:length(examples),
        example = examples(i,:);
        labels = [];
        for t = ts,
           labels(end+1) = test_tree(t{1}, example); 
        end
       predictions(i) = choose_label(labels);  
    end
end

function [label] = test_tree(t, example)
    if isempty(t.kids)
        label = t.class;
        return
    else
        kid = example(t.op) + 1;
        label = test_tree(t.kids{kid}, example);
    end
end

function [label] = choose_label(labels)
    [~, label] = max(labels);
end

function [ targets ] = binary_filter( labels, target_label );
    targets = double(labels == target_label);
end

function [ decision_tree ] = decision_tree_learning( examples, attributes, binary_targets )
    if all(binary_targets == binary_targets(1))
       decision_tree.class = binary_targets(1);
       decision_tree.kids  = [];
    elseif isempty(attributes)
        decision_tree.class = mode(binary_targets);
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

function [ new_examples, new_binary_targets ] = split_examples_targets(examples, binary_targets, attribute, value)
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
