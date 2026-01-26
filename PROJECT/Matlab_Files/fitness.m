function J = fitness(U, y, theta, K, fit_params)
% Fitness = MSE + lambda * (#active)
% Epistrefei to fitness value tou chromosomatos theta 

Phi = buildPhi(U, theta, K);
w   = solve_w_LS(Phi, y);

yhat = Phi*w;
mse  = mean((y - yhat).^2);

% active Gaussians: sxetiko threshold
ww = abs(w(2:end));
if max(ww) < 1e-12  % An ola ta varh einai poly mikra
    active = 0;     % mh valeis poinh Gaussianwn sto sfalma J, giati ousiastika den syneisferoun
else
    active = sum( ww > fit_params.w_epsilon_rel * max(ww) );    % Sxetiko active count: Oi energes Gaussian tha einai autes pou to varos tous 
                                                                % einai megalytero apo ena pososto tou megistou varous.
end                                                             % P.x an w_epsilon_rel=0.1 kai max(ww)=0.8, energes einai oses exoun |w_i|>0.08

J = mse + fit_params.lambda_active * active;
end
