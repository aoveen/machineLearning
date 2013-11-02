
function funs = trees
  funs.cross_fold_validation = @cross_fold_validation;
  funs.build_tree = @build_tree;
  funs.testTrees = @testTrees;
  funs.test_tree = @test_tree;
  funs.choose_label = @choose_label;
  funs.first_label = @first_label;
  funs.random_label = @random_label;
  funs.depth_weighted_label = @depth_weighted_label;
  funs.binary_filter = @binary_filter;
  funs.decision_tree_learning = @decision_tree_learning;
  funs.choose_best_decision_attribute = @choose_best_decision_attribute;
  funs.gain = @gain;
  funs.information = @information;
  funs.remainder = @remainder;
  funs.split_examples_targets = @split_examples_targets;
end

function [confusion] = cross_fold_validation(x, y)
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
            trees{n} = build_tree(training_data_x, training_data_y, n);
        end
        predictions = testTrees(trees, test_set_x);
        confusion = confusion + calcConfusionMatrix(test_set_y, predictions);
    end
    confusion = confusion / 10;
end

function [tree] = build_tree(x, y, attribute)
    targets = binary_filter(y, attribute);
    attributes = 1:size(x, 2);
    tree = decision_tree_learning(x, attributes, targets);
end

function [predictions] = testTrees(ts, examples)
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
    % matlab will return NaN if one of the two variables is 0 here since
    % log2(0) = -Inf and -Inf * 0 is NaN
    if pos == 0 || neg == 0
        i = 0;
    else
        i = -(pos/total)*log2(pos/total) -(neg/total)*log2(neg/total);
    end
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