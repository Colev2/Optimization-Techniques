    function H = hessianFunction(x)
% Επιστρέφει το Hessian 2x2 της f στο σημείο x

    x1 = x(1);
    x2 = x(2);

    e = exp(-x1.^2 - x2.^4);

    H11 = (4*x1.^5 - 14*x1.^3 + 6*x1) .* e;
    H12 = x1.^2 .* x2.^3 .* (8*x1.^2 - 12) .* e;
    H22 = x1.^3 .* x2.^2 .* (16*x2.^4 - 12) .* e;

    H = [H11, H12;
         H12, H22];
end