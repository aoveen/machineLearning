function [weights] = optimise_weights(x, y)
    weights = ones(1, 45);
    x = x(1:length(x)/2, :);
    y = y(1:length(y)/2);
    for i=1:45
        errors = [];
        values = 0.0:0.1:1.0;
        for w=values
            weights(i) = w;
            m = @(a, b) weighted_measure(weights, a, b);
            errors(end+1) = cross_fold(x, y, m);
            display(sprintf('TEST %s, %f, %f\n', mat2str(weights), w, errors(end)));
            %fflush(stdout); % Octave only
        end
        [~, idx] = min(errors);
        weights(i) = values(idx);
    end
    display(sprintf('RESULT %s\n', mat2str(weights)));
end

function [e] = cross_fold(x, y, m)
    folds = 10;
    confuse = zeros(6);
    for i=1:folds
        [testX, trainingX] = select_fold(x, i, folds);
        [testY, trainingY] = select_fold(y, i, folds);
        cbr = init(trainingX, trainingY, m);
        p = testCBR(cbr, testX);
        confuse = confuse + calc_confusion_matrix(testY, p);
    end
    [~, ~, ~, e] = stats(confuse);
end

function [cbr] = init(x, y, m)
    n = length(y);
    for i=1:n
        cases(i) = Case(xs2aus(x(i, :)), y(i));
    end
    cbr = nearest_k_cbr(cases, m, 3, false);
end

function [cost] = weighted_measure(weights, a, b)
    cost = -sum((a.x == b.x) .* weights);
end


