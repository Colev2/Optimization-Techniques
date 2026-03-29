function [c1,c2,s1,s2] = decode_theta(theta, K)
% theta: [c1(1..K), c2(1..K), σ1(1..K), σ2(1..K)], einai ena xrwmoswma, ena atomo
% Pairnei to theta kai to apokwdikopoiei, dhladh dinei thn timh tou kathe gene sthn antistoixh parametro
c1 = theta(1:K);   % Ta prwta K stoixeia einai ta kentra c1 twn K Gkaoussianwn
c2 = theta(K+1:2*K);    % Ta epomena K stoixeia einai ta kentra c2 twn K Gkaousianwn k.o.k
s1 = theta(2*K+1:3*K);
s2 = theta(3*K+1:4*K);

end