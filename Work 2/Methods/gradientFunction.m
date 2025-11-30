function g = gradientFunction(x)

    x1 = x(1);
    x2 = x(2);

    e = exp(-x1.^2 - x2.^4);

    g1 = x1.^2 .* (3 - 2*x1.^2) .* e;      % ∂f/∂x
    g2 = -4 * x1.^3 .* x2.^3 .* e;         % ∂f/∂y

    g = [g1; g2];
end