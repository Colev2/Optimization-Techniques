function displayMethodResults(methodName, stepType, x0, xHist, fHist, folder)
   
    % Κάνει plots:
    % 1) contour της f με την τροχιά x_k
    % 2) f(x_k) ως προς k

    % Πλέγμα για τη f
    xMin = -3; xMax = 3;
    yMin = -3; yMax = 3;
    [X, Y] = meshgrid(linspace(xMin,xMax,200), linspace(yMin,yMax,200));
    Z = objectiveFunction(X, Y);

    % ---- Contour + τροχιά ----
    figure;
    contour(X, Y, Z, 40);  
    colormap jet;
    colorbar;
    clim([min(Z(:)), max(Z(:))]);

    axis equal;
    grid on;
    
    hold on;

    scatter(xHist(1,1), xHist(1,2), 40, 'w', 'filled', 'MarkerEdgeColor', 'k');

    plot(xHist(:,1), xHist(:,2), '-o', 'MarkerSize', 8, 'MarkerFaceColor', 'black', 'MarkerEdgeColor', 'k');

    xlabel('x', 'FontSize', 20, 'FontWeight', 'bold');
    ylabel('y', 'FontSize', 20, 'FontWeight', 'bold');
    
    title(sprintf('%s | x0 = (%.2f, %.2f) | step = %s', methodName, x0(1), x0(2), stepType), ...
    'FontSize', 20, 'FontWeight', 'bold');

    set(gca,'LooseInset',get(gca,'TightInset'));
    hold off;

    fname1 = sprintf('%s/%s_%s_contour_%.2f_%.2f.png', folder, methodName, stepType, x0(1), x0(2));
    saveas(gcf, fname1);


    % ---- f(x_k) vs k ----
    figure;
    plot(0:numel(fHist)-1, fHist, '-o', 'LineWidth', 1.5);
    xlabel('iteration k', 'FontSize', 20, 'FontWeight', 'bold');
    ylabel('f(x_k)', 'FontSize', 20, 'FontWeight', 'bold');
    title(sprintf('f(x_k) – %s | x0 = (%.2f, %.2f) | step = %s', methodName, x0(1), x0(2), stepType), ...
    'FontSize', 20, 'FontWeight', 'bold');
    grid on;
    
    % Save plots
    fname2 = sprintf('%s/%s_%s_convergence_%.2f_%.2f.png', folder, methodName, stepType, x0(1), x0(2));
    saveas(gcf, fname2);
end