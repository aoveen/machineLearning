function [cbr] = CBRinit(x, y)
    n = length(y);
    for i=1:n
        cases(i) = Case(xs2aus(x(i, :)), y(i));
    end
    %cbr = basic_cbr(cases, @shared_aus_measure);
    %cbr = nearest_k_cbr(cases, @shared_aus_measure, 10);
    %cbr = nearest_k_cbr(cases, @weighted_measure, 10);
    cbr = nearest_k_cbr(cases, @jaccard_measure, 10);
    %cbr = nearest_k_cbr(cases, @dice_dissimilarity_measure, 10);
    %cbr = nearest_k_cbr(cases, @matching_dissimilarity_measure, 10);
    %cbr = nearest_k_cbr(cases, @rt_dissimilarity_measure, 10);
    %cbr = nearest_k_cbr(cases, @rr_dissimilarity_measure, 10);
    %cbr = nearest_k_cbr(cases, @ss_dissimilarity_measure, 10);
    %cbr = nearest_k_cbr(cases, @yule_dissimilarity_measure, 10);
end
