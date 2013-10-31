function [recall, precision, fs, error] = stats( confusion )
    recall = zeros(1, length(confusion));
    precision = zeros(1, length(confusion));
    fs = zeros(1, length(confusion));
    for i = 1:length(confusion)
        [class_recall, class_precision, class_f] = calculate_recall_and_precision(confusion, i);
        recall(i) = class_recall;
        precision(i) = class_precision;
        fs(i) = class_f;
    end
    error = (sum(confusion(:)) - trace(confusion)) / sum(confusion(:));
end

function [recall, precision, f1] = calculate_recall_and_precision (confusion, class)
    tp = confusion(class, class);
    fp = sum(confusion(:, class)) - tp;
    fn = sum(confusion(class, :)) - tp;
    
    recall = (tp / (tp + fn)) * 100;
    precision = (tp / (tp + fp)) * 100;
    f1 = 2 * ((precision * recall) / (precision + recall));
end