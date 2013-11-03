
function funs = trees
  funs.cross_fold_validation = @cross_fold_validation;
  funs.build_tree = @build_tree;
  funs.binary_filter = @binary_filter;
  funs.decision_tree_learning = @decision_tree_learning;
  funs.choose_best_decision_attribute = @choose_best_decision_attribute;
  funs.gain = @gain;
  funs.information = @information;
  funs.remainder = @remainder;
  funs.split_examples_targets = @split_examples_targets;
end

function [confusion] = cross_fold_validation(x, y)

    [ten_fold_data_x, ten_fold_data_y] = create_folds(10, x, y);
    
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
        predictions = test_trees(trees, test_set_x);
        confusion = confusion + calc_confusion_matrix(test_set_y, predictions);
    end
    confusion = confusion / 10;
end

function [tree] = build_tree(x, y, attribute)
    targets = binary_filter(y, attribute);
    attributes = 1:size(x, 2);
    tree = decision_tree_learning(x, attributes, targets);
end

function [targets] = binary_filter(labels, target_label)
    targets = double(labels == target_label);
end

function [decision_tree] = decision_tree_learning(examples, attributes, binary_targets)
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
    % matlab will return NaN if one of the two variables is 0 here since
    % log2(0) = -Inf and -Inf * 0 is NaN
    if pos == 0 || neg == 0
        i = 0;
    else
        total = pos + neg;
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

function [new_examples, new_binary_targets] = split_examples_targets(examples, binary_targets, attribute, value)
    attr_column = examples(:,attribute);
    rows_to_keep = attr_column == value;
    new_examples = examples(rows_to_keep, :);
    new_binary_targets = binary_targets(rows_to_keep, :);
end