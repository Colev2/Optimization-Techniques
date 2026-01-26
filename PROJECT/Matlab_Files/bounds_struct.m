function B = bounds_struct(K)
% Orismos oriwn ana gene se dianysmata lb,ub (4K genes):
% [c1(1..K), c2(1..K), s1(1..K), s2(1..K)]
% Eisodos: K: plithos Gaussianwn synarthsewn 
% Epistrefei to struct B pou periexei ta dianysmata B.lb (1x60) kai B.ub (1x60)
c1_min = -1; 
c1_max = 2;

c2_min = -2; 
c2_max = 1;

sigma_min = 0.15;  
sigma_max = 1.5;  

D = 4*K;
lb = zeros(1,D);
ub = zeros(1,D);

% layout: [c1 | c2 | s1 | s2]
lb(1:K) = c1_min;  
ub(1:K) = c1_max;

lb(K+1:2*K) = c2_min;  
ub(K+1:2*K) = c2_max;

lb(2*K+1:3*K) = sigma_min;   
ub(2*K+1:3*K) = sigma_max;

lb(3*K+1:4*K) = sigma_min;   
ub(3*K+1:4*K) = sigma_max;

% lb = [c1_min c1_min ... c1_min | c2_min c2_min ... c2_min | σ1_min ... | ... σ2_min] 
% ub = [c1_max c1_max ... c1_max | c2_max c2_max ... c2_max | σ2_max ... | ... σ2_max]

B.lb = lb;
B.ub = ub;
end
