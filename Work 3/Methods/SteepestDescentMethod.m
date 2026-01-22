function [xHist, fHist] = SteepestDescentMethod(x0, gamma, maxIter, epsilon)

    xk = x0(:);
    xHist = xk.';
    fHist = objectiveFunction(xk);

    for k = 1:maxIter
        gk = gradientFunction(xk);

        if norm(gk) < epsilon
            break;
        end

        dk = -gk;

        xk = xk + gamma * dk;

        xHist(end+1,:) = xk.';       
        fHist(end+1,1) = objectiveFunction(xk);
    end
end