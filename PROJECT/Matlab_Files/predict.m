function yhat = predict(U, theta, K, w)
    % Ypologizei kai epistrefei ta outputs ths yhat stis eisodous U, se ena dianysma Nx1 
    Phi = buildPhi(U, theta, K);
    yhat = Phi*w;
end