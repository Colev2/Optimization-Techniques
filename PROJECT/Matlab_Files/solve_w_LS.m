function w = solve_w_LS(Phi, y)
% Vriskei ta varh w mesw ths methodou Least-Squares: min||Phi*w-y||^2
w = Phi \ y;
end
