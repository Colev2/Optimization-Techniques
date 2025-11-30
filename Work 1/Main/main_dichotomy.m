clear; clc;

% Φορτωση Συναρτησεων
[f1, f2, f3] = myFunctions();
funcs = {f1, f2, f3};

% Αρχικα διαστημα 
a = -1;
b = 3;

% Δειγματα για l και ε
sampleSize = 40;

%% Part 1: Διαγραμματα πληθους υπολογισμων συναρτησης για σταθερο l, συναρτησει του ε
% Σταθερο l 
l = 0.01;

% Μεταβαλλομενο ε
epsilonList = linspace(0.0001, 0.0049, sampleSize);

% Αρχικοποιηση
fcounts = zeros(3, sampleSize);

% Για κάθε συναρτηση και για καθε epsilon 
for i = 1:3
    for j = 1:sampleSize
        eps = epsilonList(j);

        [xmin, ak, bk, fcount] = dichotomy(funcs{i}, a, b, l, eps);

        fcounts(i, j) = fcount;
    end
end

% Plots
figure;
plot(epsilonList, fcounts(1,:), '-o', 'MarkerSize', 4, 'LineWidth', 1.5); 
hold on;
plot(epsilonList, fcounts(2,:), '--', 'LineWidth', 2);
plot(epsilonList, fcounts(3,:), '-.', 'LineWidth', 2);

xlabel('\epsilon');
ylabel('f(x) evaluations = 2*k');
title('Πλήθος υπολογισμών f(x) ως προς \epsilon (l=0.01)');
legend('f1', 'f2', 'f3');
grid on;

% Save figure 
saveas(gcf, 'dichotomy_part1_epsilon_plot.png');

%% Part 2: Διαγραμματα πληθους υπολογισμων συναρτησης με σταθερο ε, συναρτησει του l

% Σταθερο epsilon 
eps = 0.001;

% Μεταβαλλομενο l 
lList = linspace(0.003, 0.1, sampleSize);

% Αρχικοποιηση
fcounts = zeros(3, sampleSize);

% Κύριος βρόχος
for i = 1:3
    for j = 1:sampleSize
        l = lList(j);

        [xmin, ak, bk, fcount] = dichotomy(funcs{i}, a, b, l, eps);

        fcounts(i, j) = fcount;
    end
end

% --- Γράφημα ---
figure;
plot(lList, fcounts(1,:), 'LineWidth', 2); hold on;
plot(lList, fcounts(2,:), '--', 'LineWidth', 2);
plot(lList, fcounts(3,:), '-.', 'LineWidth', 2);

xlabel('l (τελικό εύρος)');
ylabel('f(x) evaluations = 2*k');
title('Πλήθος υπολογισμών f(x) ως προς l (ε=0.001)');
legend('f1', 'f2', 'f3');
grid on;

% Save figure 
saveas(gcf, 'dichotomy_part2_l_plot.png');

%% Part 3:  Διαγραμματα τιμων ακρων [ak,bk] συναρτησει του k, για καθε συναρτηση, για διαφορα l

% Σταθερο ε
eps = 0.001;

% Διαφορα l
lValues = [0.0025, 0.005, 0.0075, 0.01];     % πρεπει l > 2*eps

for i = 1:3                      % μια figure για καθε συναρτηση f1,f2,f3

    figure;
    t = tiledlayout(2,2,"TileSpacing","compact","Padding","compact");
    title(t, sprintf('Μέθοδος Διχοτόμησης: Σύγκλιση άκρων για f_%d(x)', i));
    
    for li = 1:length(lValues)
        
        
        l = lValues(li);

        % Τρεχει η διχοτομηση και κραταει ολη τη λιστα των ak,bk
        [xmin, ak_list, bk_list, fcount] = dichotomy(funcs{i}, a, b, l, eps);

        k = 0:length(ak_list)-1;   % δεικτης επαναληψης (0,1,2,...)

        nexttile;
        plot(k, ak_list, '-o', 'MarkerSize', 4, 'LineWidth', 1.2); hold on;
        plot(k, bk_list, '-s', 'MarkerSize', 4, 'LineWidth', 1.2);

        title(sprintf('l = %.4f', l));
        xlabel('Επανάληψη k');
        ylabel('Τιμή άκρου');
        grid on;

        if li == 1
            legend({'a_k','b_k'}, 'Location','northeast');
        end
    end
    
    filename = sprintf('dichotomy_ak_bk_f%d.png', i);
    saveas(gcf, filename);   
    
end


%% Συγκριση υπολογιστικου ελαχιστου με πραγματικο 

l_test   = 1e-4;   
eps_test = 1e-5;   

% Ευρεση πραγματικου ελαχιστου με fminbnd
x_true = zeros(1,3);
f_true = zeros(1,3);
for i = 1:3
    [x_true(i), f_true(i)] = fminbnd(funcs{i}, a, b);
end

fprintf('\n--- Διχοτόμος χωρίς Παραγώγους : έλεγχος ακρίβειας ---\n');
for i = 1:3
    [xmin, ~, ~, ~] = dichotomy(funcs{i}, a, b, l_test, eps_test);
    fxmin = funcs{i}(xmin);

    err_x = abs(xmin - x_true(i));
    err_f = abs(fxmin - f_true(i));

   
    fprintf('f%d:\n',i);
    fprintf(' Εύρημα Αλγορίθμου: xmin = %.8f, f(xmin) = %.8f\n', xmin, fxmin);
    fprintf(' Πραγματικό ελάχιστο: x*   = %.8f,  f(x*)   = %.8f\n', x_true(i), f_true(i));
    fprintf(' Σφάλμα: |Δx| = %.2e, |Δf| = %.2e\n\n', err_x, err_f);
end