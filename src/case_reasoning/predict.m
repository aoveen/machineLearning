function [y] = predict(cbr, x)
    new_case = Case(xs2aus(x));
    best_fit = cbr.retrieve(cbr, new_case);
    new_case = cbr.reuse(best_fit, new_case);
    y = new_case.label;
end

