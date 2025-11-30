clear; close all; clc;

starts = [ 0  0; -1 -1; 1  1];

stepTypes = {'constant', 'exact', 'armijo'};
gamma0    = 1.0;

 for j = 1:numel(stepTypes)
    stepType = stepTypes{j};   

    for s = 1:size(starts,1)
         x0 = starts(s,:).';
         [xHist, fHist] = NewtonMethod(x0, stepType, gamma0, 200, 1e-6);
         displayMethodResults('Newton', stepType, x0, xHist, fHist, 'plots/Newton');
    end
end