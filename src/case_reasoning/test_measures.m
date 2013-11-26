folds = 10;

confuse = zeros(6);

measures = {
    @rubbish_measure,
    @shared_aus_measure,
    @weighted_measure,
    @jaccard_measure,
    @dice_dissimilarity_measure,
    @matching_dissimilarity_measure,
    @rt_dissimilarity_measure,
    @rr_dissimilarity_measure,
    @ss_dissimilarity_measure,
    @yule_dissimilarity_measure
};

names = {'rubbish_measure', 'shared_aus_measure', 'weighted_measure','jaccard_measure','dice_dissimilarity_measure','matching_dissimilarity_measure','rt_dissimilarity_measure','rr_dissimilarity_measure','ss_dissimilarity_measure','yule_dissimilarity_measure'};

folds = 10;
newx = x(1:length(x), :);
newy = y(1:length(y));

for i=1:length(measures)
    m = measures(i);
    name = names(i);
    confuse = zeros(6);
    display(sprintf('Checking results for measure "%s"\n', name{1}));
    % cases = [];
    
    for j=1:folds
        [testX, trainingX] = select_fold(newx, j, folds);
        [testY, trainingY] = select_fold(newy, j, folds);
        n = length(trainingY);
        for k=1:n
            cases(k) = Case(xs2aus(trainingX(k, :)), trainingY(k));
        end
        cbr = nearest_k_cbr(cases, m, 10, true);
        p = testCBR(cbr, testX);
        confuse = confuse + calc_confusion_matrix(testY, p);
    end
    confuse;
    [p, r, f, e] = stats(confuse);
    display(sprintf('RESULT %s = %f\n', name{1}, e));
    save(strcat('results_nearest_k10_noisy_', name{1}), 'confuse', 'p', 'r', 'f', 'e');
    %fflush(stdout); % Octave only
end
