    %% mainPlot.m – Σχεδίαση της f(x,y)
clear; close all; clc;

x = linspace(-3, 3, 200);
y = linspace(-3, 3, 200);
[X, Y] = meshgrid(x, y);
Z = objectiveFunction(X, Y);

% 3D επιφάνεια
figure;
surf(X, Y, Z);
xlabel('x'); 
ylabel('y'); 
zlabel('f(x,y)');
title('f(x,y) = x^3 e^{-x^2 - y^4}');
shading interp; 
grid on;

saveas(gcf, 'plots/Functiongraphs/f_3D.png');

% Contour plot
figure;
contour(X, Y, Z, 40);
xlabel('x'); 
ylabel('y');
title('Contours της f(x,y)');
axis equal; 
grid on;

saveas(gcf, 'plots/FunctionGraphs/f_contour.png');