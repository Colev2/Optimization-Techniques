    %% mainPlot.m – Σχεδίαση της f(x,y)
clear; close all; clc;

x1 = linspace(-15, 15, 300);
x2 = linspace(-15, 15, 300);
[X1, X2] = meshgrid(x1, x2);
Z = objectiveFunction(X1, X2);

% 3D επιφάνεια
figure;
surf(X1, X2, Z);
xlabel('x'); 
ylabel('y'); 
zlabel('f(x,y)');
title('3D graph of f(x1,x2)');
shading interp; 
grid on;

saveas(gcf, 'plots/FunctionGraphs/f_3D.png');

% Contour plot
figure;
contour(X1, X2, Z, 40);
xlabel('x'); 
ylabel('y');
title('Contours της f(x,y)');
axis equal; 
grid on;

saveas(gcf, 'plots/FunctionGraphs/f_contour.png');