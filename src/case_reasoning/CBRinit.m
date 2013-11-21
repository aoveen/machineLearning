function [cbr] = CBRinit(x, y)
    n = length(y);
    for i=1:n
        cases(i) = Case(xs2aus(x(i, :)), y(i));
    end
    
    %cbr = basic_cbr(cases, @shared_aus_measure);
    cbr = nearest_k_cbr(cases, @shared_aus_measure, 10);
end
