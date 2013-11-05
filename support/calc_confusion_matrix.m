function [confusion] = calc_confusion_matrix(actual, predictions)
%CALCCONFUSIONMATRIX Given a vector of labels and predicted labels generates
% a confusion matrix.
    confusion = zeros(6, 6);
    for i = 1:length(actual),
        confusion(actual(i), predictions(i)) = confusion(actual(i), predictions(i)) + 1;
    end
end

