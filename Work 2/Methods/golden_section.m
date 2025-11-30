function [xmin, ak_list, bk_list, fcount] = golden_section(f, a, b, l)

    % Μέθοδος Χρυσού Τομέα για ελαχιστοποίηση σε [a,b] με ακρίβεια l

    gamma = (sqrt(5) - 1) / 2;      % ≈ 0.618
    ak = a;
    bk = b;

    ak_list = ak;
    bk_list = bk;

    % Αρχικές εσωτερικές τιμές
    x1 = ak + (1 - gamma) * (bk - ak);
    x2 = ak + gamma * (bk - ak);

    f1 = f(x1);
    f2 = f(x2);
    fcount = 2;                   % 2 υπολογισμοι στο 1ο βημα
    while (bk - ak) > l

        if f1 > f2
            % Κραταμε [x1, bk]
            ak = x1;
            x1 = x2;
            f1 = f2;

            x2 = ak + gamma * (bk - ak);
            f2 = f(x2);
        else
            % Κραταμε [ak, x2]
            bk = x2;
            x2 = x1;
            f2 = f1;

            x1 = ak + (1 - gamma) * (bk - ak);
            f1 = f(x1);
        end

        fcount = fcount + 1;    % σε καθε βημα κανουμε 1 υπολογισμο της f

        ak_list(end+1) = ak;
        bk_list(end+1) = bk;
    end

    xmin = (ak + bk) / 2;
end


