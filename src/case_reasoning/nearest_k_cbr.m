function [cbr] = nearest_k_cbr(cases, measure, k)
    cbr = struct('cases', cases, ...
                 'measure', measure, ...
                 'k', k, ...
                 'retain', @nearest_k_retain, ...
                 'reuse', @reuse, ...
                 'predict', @predict, ...
                 'retrieve', @nearest_k_retrieve );
end

function [the_cbr] = nearest_k_retain(cbr, solvedcase)
    cbr.cases(end+1) = solvedcase;
    the_cbr = 0;
end

function [best_match] = nearest_k_retrieve(cbr, newcase)
    m = cbr.measure;
    the_cases = cbr.cases;
    costs = 1:length(the_cases);
    
    for j=1:length(the_cases)
        costs(j) = m(the_cases(j), newcase);
    end
    
    [~, idx] = sort(costs);
    lowest_k = the_cases(idx(1:cbr.k));
    c = cell(1, cbr.k);
    [c{:}] = lowest_k.label;
    lowest_idx = [c{:}];
    best_label = mode(lowest_idx);
    best_idx = find(lowest_idx==best_label);
    best_match = lowest_k(best_idx(1));
end
