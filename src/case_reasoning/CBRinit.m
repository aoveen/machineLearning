function [cbr] = CBRinit(x, y)
    n = length(y);
    for i=1:n
        cases(i) = Case(xs2aus(x(i, :)), y(i));
    end
    cbr = struct('cases', cases);
end
