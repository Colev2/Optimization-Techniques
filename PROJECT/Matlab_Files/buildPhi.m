function Phi = buildPhi(U, theta, K)
% Xtizei ton pinaka Phi: N x (K+1), h prwth sthlh einai assoi giati orisa G_0=1
% H grammh i tou Phi einai to deigma i, enw h sthlh k einai h gkaousiannh Gk. 
% To stoixeio Phi[i][k] einai h timh ths Gkaousianhs Gk gia to deigma i
% Gia na xtisei ton pinaka Phi xreiazetai ta deigmata U kai tis parametrous (theta), ta opoia pairnei ws orismata
[c1,c2,s1,s2] = decode_theta(theta, K);
u1 = U(:,1); 
u2 = U(:,2);
N = size(U,1);

Phi = zeros(N, K+1);
Phi(:,1) = 1;  % bias

for k = 1:K
    a = ((u1 - c1(k)).^2) ./ (2*s1(k)^2);
    b = ((u2 - c2(k)).^2) ./ (2*s2(k)^2);
    Phi(:,k+1) = exp(-(a + b));
end
end
