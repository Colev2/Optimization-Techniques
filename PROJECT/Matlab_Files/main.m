clear; clc; close all;

% Parametroi

K = 15;             % max arithmos Gaussians
Ntrain = 600;       % Dedomena ekpaideusis  
Nval = 200;         % Validation Data
Ntest  = 200;       % Test Data

ga_params.pop_size   = 150;       % plhthysmos    
ga_params.generations = 800;      % Genies
ga_params.elite_count = 3;        % Plithos atomwn pou epiviwnoun ws kalyteroi kai pernane autousia ston epomeno plhthysmo

ga_params.tournament_size = 3;    % Plithos atomwn pou epilegoume gia sygkrish kai kratame ton kalytero ws gonio

ga_params.crossover_rate = 0.9;   % Pithanotita crossover
ga_params.blx_alpha      = 0.2;   % Stathera gia th dhmiourgia paidiwn sto crossover

ga_params.mutation_rate  = 0.07;  % Pithanotita mutation
ga_params.mutation_scale = 0.05;  % Vhma mutation 

fit_params.lambda_active = 3e-4;  % Poinh energwn Gaussianwn sth fitness function
fit_params.w_epsilon_rel = 0.05;  % sxetiko threshold gia ton kathorismo ths poinhs twn energwn Gaussianwn sth fitness

rng(1);     % Gia anaparagwgimothta

% Dhmiourgia Training, Validation, Test Data

[Utr, ytr, Uval, yval, Ute, yte] = make_data(Ntrain, Nval, Ntest);

% Bounds gia chromosome
B = bounds_struct(K);

% Run GA
[best_theta, best_hist] = ga_run(Utr, ytr, B, ga_params, fit_params);       

% Vriskw ta varh w me vash ta dedomena ekpaideushs 
w_best = fit_weights(Utr, ytr, best_theta, K);

% Outputs ths yhat sta training/validation/test data me ta ekpaideumena varh 
yhat_tr  = predict(Utr,  best_theta, K, w_best);
yhat_val = predict(Uval, best_theta, K, w_best);
yhat_te  = predict(Ute,  best_theta, K, w_best);

mse_tr = mean((ytr - yhat_tr).^2);
mse_val = mean((yval - yhat_val).^2);
mse_test = mean((yte - yhat_te).^2);

% Vriskw poses Gaussian einai active
ww = abs(w_best(2:end));
if max(ww) < 1e-12
    active = 0;
else
    active = sum( ww > fit_params.w_epsilon_rel * max(ww) );
end


% Ektypwsh
fprintf('\n=== RESULTS ===\n');
fprintf('Train MSE: %.6f\n', mse_tr);
fprintf('Validation  MSE: %.6f\n', mse_val);
fprintf('Test MSE: %.6f\n', mse_test);
fprintf('Active Gaussians: %d / %d\n', active, K);


% Plots

figure; 
plot(best_hist, 'LineWidth', 1.5);
xlabel('Generation'); 
ylabel('Best fitness');
title('GA progress', 'FontSize', 16, 'FontWeight', 'bold'); 
grid on;

% Scatter Diagramma
figure;
scatter(yte, yhat_te, 12, 'filled'); 
grid on;
xlabel('True y (test)'); 
ylabel('Predicted yhat (test)');
title('y vs yhat (test set)', 'FontSize', 16, 'FontWeight', 'bold');
refline(1,0);

% 3D Epifaneies ths pragmatikhs y kai ths proseggistikhs y_hat
u1 = linspace(-1,2,60);
u2 = linspace(-2,1,60);
[U1,U2] = meshgrid(u1,u2);
Ug = [U1(:), U2(:)];
Ytrue = true_f(Ug(:,1), Ug(:,2));
Yhat = predict(Ug, best_theta, K, w_best);

figure;
surf(U1, U2, reshape(Ytrue, size(U1)));
xlabel('u1'); 
ylabel('u2'); 
zlabel('f');
title('True f(u1,u2)', 'FontSize', 16, 'FontWeight', 'bold'); 
shading interp;

figure;
surf(U1, U2, reshape(Yhat, size(U1)));
xlabel('u1'); 
ylabel('u2'); 
zlabel('fhat');
title('Model fhat(u1,u2)', 'FontSize', 16, 'FontWeight', 'bold'); 
shading interp;

Ztrue = reshape(Ytrue, size(U1));
Zhat  = reshape(Yhat,  size(U1));
