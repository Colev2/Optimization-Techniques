function w = fit_weights(Utr, ytr, theta, K)
    % Ypologizei kai epistrefei ta varh w panw sta dedomena Utr, ytr
    Phi_tr = buildPhi(Utr, theta, K);
    w = solve_w_LS(Phi_tr, ytr);
end
