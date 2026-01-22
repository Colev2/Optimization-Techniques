clear; close all; clc;
     
gammaValues = [0.1 0.3 3 5];
x0 = [5; -5];

for i = 1:numel(gammaValues)
    
    gamma = gammaValues(i);

    [xHist, fHist] = SteepestDescentMethod(x0, gamma, 500, 1e-3);

    methodName = sprintf('Steepest Descent - Θέμα 1 (γ = %.1f)', gamma);

    displayMethodResults(methodName, x0, xHist, fHist);

    % Για λογαριθμικη κλιμακα στο f(xk)-k
    if gamma ==3 || gamma == 5
        
        figure;
        k = 0:numel(fHist)-1;
        semilogy(k, fHist, '-o', 'LineWidth', 1.5);
        grid on;
        xlabel('iteration k', 'FontSize', 20, 'FontWeight', 'bold');
        ylabel('f(x_k)', 'FontSize', 20, 'FontWeight', 'bold');
        title(sprintf('f(x_k) – Steepest Descent - Θέμα 1 (log scale, γ = %.1f) | x0 = (%.2f, %.2f)', ...
              gamma, x0(1), x0(2)), 'FontSize', 18, 'FontWeight', 'bold');

        fname_log = sprintf('plots/SD_convergence_log_gamma_%.1f_%.2f_%.2f.png', gamma, x0(1), x0(2));
        saveas(gcf, fname_log);
    end
end