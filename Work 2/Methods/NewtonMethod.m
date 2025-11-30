function [xHist, fHist] = NewtonMethod(x0, stepType, gamma0, maxIter, epsilon)

    xk    = x0(:);                 
    xHist = xk.';                  
    fHist = objectiveFunction(xk);  

    for k = 1:maxIter
        gk = gradientFunction(xk);

        if norm(gk) < epsilon
            break;
        end

        Hk = hessianFunction(xk);

        % --- Ελεγχος αντιστρεψιμοτητας Hessian ---
        if abs(det(Hk)) < 1e-12      
            disp('Hessian μη αντιστρεψιμος – Newton δεν μπορεί να εφαρμοστει.');
            break;
        end

        dk = - Hk \ gk;

        gamma = gammaMethod(xk, dk, stepType, gamma0);

        xk = xk + gamma * dk;

        xHist(end+1,:) = xk.';
        fHist(end+1,1) = objectiveFunction(xk);
    end
end 