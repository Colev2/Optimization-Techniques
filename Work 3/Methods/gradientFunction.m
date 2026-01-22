function g = gradientFunction(x)
    
    x1 = x(1);
    x2 = x(2);

    g1 = (2/3)*x1;      % ∂f/∂x1
    g2 = 6*x2;          % ∂f/∂x2

    g = [g1; g2];

end