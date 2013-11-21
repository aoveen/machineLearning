function [solvedcase] = reuse(acase, newcase)
    solvedcase = newcase;
    solvedcase.label = acase.label;
end
