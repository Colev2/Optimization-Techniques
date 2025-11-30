clear; close all; clc;

starts = [ 0  0; -1 -1; 1  1];

stepTypes = {'constant', 'exact', 'armijo'};
gamma0     = 1.0;              
gammaConst = [2.0 0.5 0.01];  

for i = 1:numel(stepTypes)
    stepType = stepTypes{i};

    for s = 1:size(starts,1)
        x0 = starts(s,:).';
        
        if strcmp(stepType,'constant')
            for g0=gammaConst
            [xHist, fHist] = SteepestDescentMethod(x0, stepType, g0, 200, 1e-6);
            methodName = sprintf('Steepest Descent (γ = %.2f)', g0);
            displayMethodResults(methodName, stepType, x0, xHist, fHist, 'plots/Steepest Descent');
            end
        else

            [xHist, fHist] = SteepestDescentMethod(x0, stepType, gamma0, 200, 1e-6);
            displayMethodResults('SteepestDescent', stepType, x0, xHist, fHist, 'plots/Steepest Descent');
        end
    end
end