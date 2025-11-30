function [xHist, fHist] = LevenbergMarquardtMethod(x0, stepType, gamma0, maxIter, epsilon)

    xk = x0(:);
    xHist = xk.';
    fHist = objectiveFunction(xk);

    for k = 1:maxIter
        gk = gradientFunction(xk);

        if norm(gk) < epsilon
            break;
        end
        
        Hk    = hessianFunction(xk);
        eigsH = eigs(Hk);
        lambda_min = min(eigsH);

        if lambda_min > 0
            mk_LM = 0;                  % Hessian ΟΚ → καθαρή Newton
        else
            mk_LM = -lambda_min + 0.5; % έχει αρνητικές → σπρώχνουμε όλες πάνω
        end
        
        HLm = Hk + mk_LM * eye(2);
        dk  = - HLm \ gk;
        gamma = gammaMethod(xk, dk, stepType, gamma0);   % π.χ. constant → gamma = 1
        xk = xk + gamma * dk;

        xHist(end+1,:) = xk.';      
        fHist(end+1,1) = objectiveFunction(xk);
    end
end