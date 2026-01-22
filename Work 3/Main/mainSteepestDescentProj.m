clear; clc; close all;

% Περιορισμοι: -10 ≤ x1 ≤ 5,  -8 ≤ x2 ≤ 12
Restraints = [-10 5; -8  12];

epsilon = 0.01;         
maxIter = 300;

%% Θεμα 2

x0      = [5; -5];      
s       = 5;            
gamma   = 0.5;          
          
[xHist2, fHist2] = SteepestDescentProj(x0, gamma, s, maxIter, epsilon, Restraints);
displayMethodResults('Projected Steepest Descent (Θέμα 2)', x0, xHist2, fHist2);


%% Θεμα 3

x0      = [-5; 10];      
s       = 1;            
gamma   = 0.1;          
          
[xHist2, fHist2] = SteepestDescentProj(x0, gamma, s, maxIter, epsilon, Restraints);
displayMethodResults('Projected Steepest Descent (Θέμα 3)', x0, xHist2, fHist2);

%% Θεμα 4

x0      = [8; -10];      
s       = 0.1;            
gamma   = 0.2;          
 
[xHist2, fHist2] = SteepestDescentProj(x0, gamma, s, maxIter, epsilon, Restraints);
displayMethodResults('Projected Steepest Descent (Θέμα 4)', x0, xHist2, fHist2);