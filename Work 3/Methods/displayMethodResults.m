function displayMethodResults(methodName, x0, xHist, fHist)
   
    X = xHist.';              
    fHist = fHist(:).';

    x1_traj = X(1, :);
    x2_traj = X(2, :);

    % (1) Contour 
    xMin = -15; xMax = 15;
    yMin = -15; yMax = 15;

    x1 = linspace(xMin, xMax, 200);
    x2 = linspace(yMin, yMax, 200);
    [X1, X2] = meshgrid(x1, x2);
    Z = objectiveFunction(X1, X2);

    figure;
    contour(X1, X2, Z, 40);
    colormap jet;
    colorbar;
    clim([min(Z(:)), max(Z(:))]);

    axis([xMin xMax yMin yMax]);
    axis equal;
    grid on;
    hold on;


    % Αρχικό σημείο
    scatter(x1_traj(1), x2_traj(1), 40, 'w', 'filled', 'MarkerEdgeColor', 'k');

    % Τροχιά x_k
    plot(x1_traj, x2_traj, '-o', 'MarkerSize', 6, 'MarkerFaceColor', 'black', 'MarkerEdgeColor', 'k');

    xlabel('x_1', 'FontSize', 20, 'FontWeight', 'bold');
    ylabel('x_2', 'FontSize', 20, 'FontWeight', 'bold');
    title(sprintf('%s | x0 = (%.2f, %.2f)', methodName, x0(1), x0(2)), 'FontSize', 20, 'FontWeight', 'bold');

    hold off;

    fname1 = sprintf('plots/%s_contour_%.2f_%.2f.png', methodName, x0(1), x0(2));
    saveas(gcf, fname1);


    % (2) Convergence - f(x_k) vs k 
    figure;
    k = 0:numel(fHist)-1;
    plot(k, fHist, '-o', 'LineWidth', 1.5);
    xlabel('iteration k', 'FontSize', 20, 'FontWeight', 'bold');
    ylabel('f(x_k)', 'FontSize', 20, 'FontWeight', 'bold');
    title(sprintf('f(x_k) – %s | x0 = (%.2f, %.2f)', methodName, x0(1), x0(2)), 'FontSize', 20, 'FontWeight', 'bold');
    grid on;

    fname2 = sprintf('plots/%s_convergence_%.2f_%.2f.png', methodName, x0(1), x0(2));
    saveas(gcf, fname2);


    % (3) x1_k, x2_k vs k
    figure;
    k = 0:numel(x1_traj)-1;
    plot(k, x1_traj, '-o', 'LineWidth', 1.5); hold on;
    plot(k, x2_traj, '-s', 'LineWidth', 1.5);
    hold off;
    xlabel('iteration k', 'FontSize', 20, 'FontWeight', 'bold');
    ylabel('x_1(k), x_2(k)', 'FontSize', 20, 'FontWeight', 'bold');
    legend('x_1(k)', 'x_2(k)', 'Location', 'best');
    title(sprintf('Coordinates – %s | x0 = (%.2f, %.2f)', methodName, x0(1), x0(2)), 'FontSize', 20, 'FontWeight', 'bold');
    grid on;

    fname3 = sprintf('plots/%s_coords_%.2f_%.2f.png', methodName, x0(1), x0(2));
    saveas(gcf, fname3);

end