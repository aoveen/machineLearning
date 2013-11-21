%% Basic CBR
% Basic CBR keeps a list of all the cases it's seen.
% When asked to retrieve a best match to a new case it looks through the list and
% calculates the diffrence (cost) between the new case and each stored case
% (as defined by the passed in measure function).
% We then pick one of the stored cases with the minimum at random to return.

function [ cbr ] = basic_cbr( cases, measure )
    cbr = struct('cases', cases, ...
                 'measure', measure, ...
                 'retain', @basic_retain, ...
                 'reuse', @reuse, ...
                 'predict', @predict, ...
                 'retrieve', @basic_retrieve );
end

function [the_cbr] = basic_retain(cbr, solvedcase)
    cbr.cases(end+1) = solvedcase;
    the_cbr = 0;
end

function [best_match] = basic_retrieve(cbr, newcase)
    m = cbr.measure;
    the_cases = cbr.cases;
    costs = 1:length(the_cases);
    
    for j=1:length(the_cases)
        costs(j) = m(the_cases(j), newcase);
    end

    [min_cost, ~] = min(costs);                 % Get the the minimum cost 
    minimum_cost_cases = find(costs==min_cost); % Find all the minimum cost examples
    i = datasample(minimum_cost_cases, 1);      % Pick minimum example at random
    best_match = cbr.cases(i);
end
