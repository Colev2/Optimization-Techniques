clear; close all; clc;

% Φορτωση συναρτησεων
[f1, f2, f3] = myFunctions();
funcs = {f1, f2, f3};

% Αρχικο διαστημα
a = -1;
b = 3;

%% Part 1: Πληθος υπολογισμων συναρτησης συναρτησει του l

% Μεταβαλλομενο l 
sampleSize = 40;
lList = linspace(0.001, 0.1, sampleSize);   

% Αρχικοποιηση
fcounts = zeros(3, sampleSize);

% Loop για f1, f2, f3
for i = 1:3
    for j = 1:sampleSize
        l = lList(j);

        [xmin, ak_list, bk_list, fcount] = Fibonacci(funcs{i}, a, b, l);

        fcounts(i, j) = fcount;
    end
end

% Plots
figure;
plot(lList, fcounts(1,:), '-o', 'MarkerSize', 4, 'LineWidth', 1.5); hold on;
plot(lList, fcounts(2,:), '--', 'LineWidth', 2);
plot(lList, fcounts(3,:), '-.', 'LineWidth', 2);

xlabel('l (τελικό εύρος)');
ylabel('f(x) evaluations = k+1');
title('Πλήθος υπολογισμών f(x) ως προς l (Μέθοδος Fibonacci)');
legend('f1', 'f2', 'f3');
grid on;

% Save Figure
saveas(gcf, 'Fibonacci_part1_l_plot.png');


%% Part 2: Διαγραμματα τιμων ακρων [ak,bk] συναρτησει του k, για καθε συναρτηση, για διαφορα l

% Διαφορες τιμες του l
lValues = [0.000001 0.00001 0.0005 0.01];   

for i = 1:3    % ενα figure για καθε συναρτηση f_i

    figure;
    t = tiledlayout(2, 2, "TileSpacing", "compact", "Padding", "compact");
    title(t, sprintf('Μέθοδος Fibonacci: Σύγκλιση άκρων για f_%d(x)', i), ...
        'FontSize', 16);

    for li = 1:numel(lValues)
        l = lValues(li);

        % Τρεχει η μεθοδος και κραταει ολες τις τιμες a_k, b_k
        [xmin, ak_list, bk_list, fcount] = Fibonacci(funcs{i}, a, b, l);

        k = 0:numel(ak_list)-1;   % δεικτης επαναληψης k = 0,1,2,...

        nexttile;
        plot(k, ak_list, '-o', 'MarkerSize', 4, 'LineWidth', 1.3); hold on;
        plot(k, bk_list, '-s', 'MarkerSize', 4, 'LineWidth', 1.3);

        title(sprintf('l = %.4f', l), 'FontSize', 13);
        xlabel('Επανάληψη k');
        ylabel('Τιμή άκρου');
        grid on;

        if li == 1
            legend({'a_k','b_k'}, 'Location', 'best');
        end
    end

    % Save figure
    saveas(gcf, sprintf('Fibonacci_ak_bk_f%d.png', i));
end


%% Συγκριση υπολογιστικου ελαχιστου με πραγματικο 

l_test   = 1e-4;   

% Ευρεση πραγματικου ελαχιστου με fminbnd
x_true = zeros(1,3);
f_true = zeros(1,3);
for i = 1:3
    [x_true(i), f_true(i)] = fminbnd(funcs{i}, a, b);
end

fprintf('\n--- Fibonacci : έλεγχος ακρίβειας ---\n');
for i = 1:3
    [xmin, ~, ~, ~] = Fibonacci(funcs{i}, a, b, l_test);
    fxmin = funcs{i}(xmin);

    err_x = abs(xmin - x_true(i));
    err_f = abs(fxmin - f_true(i));

   
    fprintf('f%d:\n',i);
    fprintf(' Εύρημα Αλγορίθμου: xmin = %.8f, f(xmin) = %.8f\n', xmin, fxmin);
    fprintf(' Πραγματικό ελάχιστο: x*   = %.8f,  f(x*)   = %.8f\n', x_true(i), f_true(i));
    fprintf(' Σφάλμα: |Δx| = %.2e, |Δf| = %.2e\n\n', err_x, err_f);
end