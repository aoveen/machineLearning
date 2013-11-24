function [weights] = optimise_k(x, y)
    x = x(1:length(x)/2, :);
    y = y(1:length(y)/2);
    errors = [];
    for k=1:100
        errors(end+1) = cross_fold(x, y, k);
        printf('TEST %d, %f\n', k, errors(end));
        fflush(stdout); % Octave only
    end
    [~, k] = min(errors);
    printf('RESULT %d\n', k);
end

function [e] = cross_fold(x, y, k)
    folds = 10;
    confuse = zeros(6);
    for i=1:folds
        [testX, trainingX] = select_fold(x, i, folds);
        [testY, trainingY] = select_fold(y, i, folds);
        cbr = init(trainingX, trainingY, k);
        p = testCBR(cbr, testX);
        confuse = confuse + calc_confusion_matrix(testY, p);
    end
    [~, ~, ~, e] = stats(confuse);
end

function [cbr] = init(x, y, k)
    n = length(y);
    for i=1:n
        cases(i) = Case(xs2aus(x(i, :)), y(i));
    end
    cbr = nearest_k_cbr(cases, @weighted_measure, k);
end


