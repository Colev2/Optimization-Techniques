function [f1, f2, f3] = myFunctions()

    f1 = @(x) 5.^x + (2 - cos(x)).^2;
    f2 = @(x) (x - 1).^2 + exp(x - 5).*sin(x + 3);
    f3 = @(x) exp(-3*x) - (sin(x - 2) - 2).^2;

end