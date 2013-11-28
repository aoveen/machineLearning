function [cbr] = nearest_k_cbr(cases, measure, k, dynamic_optimise)
    cbr = struct('cases', cases, ...
                 'measure', measure, ...
                 'k', k, ...
                 'retain', @nearest_k_retain, ...
                 'reuse', @reuse, ...
                 'predict', @predict, ...
                 'retrieve', @nearest_k_retrieve, ...
                 'dynamic_optimise', dynamic_optimise);

    if cbr.dynamic_optimise
       optimise_k(cbr) 
    end
end

function [the_cbr] = nearest_k_retain(cbr, solvedcase)
    cbr.cases(end+1) = solvedcase;
    if cbr.dynamic_optimise
       optimise_k(cbr) 
    end
    the_cbr = cbr;
end

function optimise_k(cbr)
    folds = 3;
    k_limit = floor(length(cbr.cases)*2/3);
    errors = zeros(1,k_limit);
    for k = 1:k_limit,
        confusion = zeros(6);
        for i = 1:folds
            [testX, trainingX] = select_fold(cell2mat(arrayfun(@(c) c.x, cbr.cases, 'UniformOutput', false)'), i, folds);
            [testY, trainingY] = select_fold([cbr.cases.label]', i, folds);

            n = length(trainingY);
            
            for j=1:n
                cases(j) = Case(xs2aus(trainingX(j, :)), trainingY(j));
            end
            cbr = nearest_k_cbr(cases, cbr.measure, k, false);
            p = testCBR(cbr, testX);
            confusion = confusion + calc_confusion_matrix(testY, p);
        end
        confusion = confusion/folds;
        [~,~,~,e] = stats(confusion);
        display(sprintf('TEST K=%d (error:%f);', k, e));
        errors(k) = e;
    end
    [min_error, min_idx] = min(errors);
    display(sprintf('OPTIMISED K=%d (error:%f)\n', min_idx, min_error));

    cbr.k = min_idx;
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
    
    retain_case = newcase;
    retain_case.label = best_label;
    cbr.retain(cbr, retain_case);
end
