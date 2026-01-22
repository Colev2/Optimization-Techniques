function [xHist, fHist] = SteepestDescentProj(x0, gamma, s, maxIter, epsilon, Restraints)

% Εισοδος:
%   x0        : αρχικo σημεiο 
%   gamma     : μηκος βηματος στο διανυσμα κατευθυνσης xk_bar-xk
%   s         : μηκος βήματος στην SD πριν τους περιορισμους
%   maxIter   : μεγιστος αριθμος επαναληψεων
%   epsilon   : ακριβεια 
%   Restraints: πινακας Nx2 με τα κατωτερα / ανωτερα ορια
%
% Εξοδος:
%   xHist     : ιστορικο των x_k (καθε σειρα ειναι ενα x_k)
%   fHist     : ιστορικο των f(x_k)

    % x0 διανυσμα στηλη
    xk = x0(:);

    % Προβολη του αρχικου σημειου στο εφικτο συνολο σε περιπτωση που είναι εκτος
    xk = Projection(xk, Restraints);

    % Αρχικοποιηση ιστορικου
    xHist = xk.';                  
    fHist = objectiveFunction(xk);

    for k = 1:maxIter
        
        % Υπολογισμος gradient
        gk = gradientFunction(xk);

        % Διανυσμα κατευθυνσης
        dk = -gk;

        % Βημα Steepest Descent χωρις περιορισμούς (μηκους s)
        yk = xk + s * dk;

        % Προβολη 
        xk_bar = Projection(yk, Restraints);
        
        
        % Κριτηριο Τερματισμου
        if norm(xk_bar-xk)<epsilon
            break;
        end

        % Τελικο βημα μεσα στο εφικτο συνολο 
        xk = xk + gamma * (xk_bar - xk);

        % Ενημερωση ιστορικου
        xHist(end+1,:) = xk.';                  
        fHist(end+1,1) = objectiveFunction(xk); 
    end
end
