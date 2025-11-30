function f = objectiveFunction(x, y)

    if nargin == 1
        x1 = x(1);
        x2 = x(2);
        f = x1.^3 .* exp(-x1.^2 - x2.^4);
    else
        f = x.^3 .* exp(-x.^2 - y.^4);
    end
end