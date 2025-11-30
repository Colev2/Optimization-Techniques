function [xmin, ak_list, bk_list, fcount] = Fibonacci(f, a, b, l)

    % Βρες τα βηματα n φτιαχνοντας τον n-οστο Fibonacci τετοιο που να ξεπερασει το (b-a)/l 
    F = [1 1];                   % F1 = 1, F2 = 1
    n = 2;
    while F(end) < (b - a) / l
        F(end+1) = F(end) + F(end-1);
        n = n + 1;
    end
    % Τωρα F(n) >= (b-a)/l
    
    % Αρχικοποιηση
    ak = a;
    bk = b;

    ak_list = ak;
    bk_list = bk;

    % Αρχικα σημεια 
    x1 = ak + F(n-2) / F(n) * (bk - ak);
    x2 = ak + F(n-1) / F(n) * (bk - ak);

    f1 = f(x1);
    f2 = f(x2);
    fcount = 2;                  % μεχρι τωρα 2 υπολογισμοι f(x)

    % Κυριως βροχος: k = 1,..., n-2 ---
    for k = 1:(n-2)
        if f1 > f2
            % Κραταμε [x1, bk]
            ak = x1;
            x1 = x2;
            f1 = f2;

            x2 = ak + F(n-k) / F(n-k+1) * (bk - ak);
            f2 = f(x2);
        else
            % Κραταμε [ak, x2]
            bk = x2;
            x2 = x1;
            f2 = f1;

            x1 = ak + F(n-k-1) / F(n-k+1) * (bk - ak);
            f1 = f(x1);
        end

        fcount = fcount + 1;     % καθε iteration ενας νεος υπολογισμος f(x)

        ak_list(end+1) = ak;
        bk_list(end+1) = bk;
    end

    xmin = (ak + bk) / 2;
end