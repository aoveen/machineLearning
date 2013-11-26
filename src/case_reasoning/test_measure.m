function test_measure(x, y, measure, name, type)
    folds = 10;
    newx = x(1:length(x), :);
    newy = y(1:length(y));

    confuse = zeros(6);
    display(sprintf('Checking results for measure "%s"\n', name));

    for j=1:folds
        [testX, trainingX] = select_fold(newx, j, folds);
        [testY, trainingY] = select_fold(newy, j, folds);
        n = length(trainingY);
        for k=1:n
            cases(k) = Case(xs2aus(trainingX(k, :)), trainingY(k));
        end
        cbr = nearest_k_cbr(cases, measure, 10, true);
        p = testCBR(cbr, testX);
        confuse = confuse + calc_confusion_matrix(testY, p);
    end
    [p, r, f, e] = stats(confuse);
    display(sprintf('RESULT %s = %f\n', name, e));
    save(strcat(strcat('results_nearest_k_', name), type), 'confuse', 'p', 'r', 'f', 'e');
    %fflush(stdout); % Octave only
end