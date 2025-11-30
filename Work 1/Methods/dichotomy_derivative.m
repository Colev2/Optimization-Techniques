function [xmin, ak_list, bk_list, fcount] = dichotomy_derivative(df, a, b, l)

    ak = a;
    bk = b;

    ak_list = ak;
    bk_list = bk;

    fcount = 0;

    % Κυρίως βρόχος
    while (bk - ak) > l

        % μεσαίο σημείο
        mid = (ak + bk) / 2;

        % παράγωγος στο mid
        g = df(mid);
        fcount = fcount + 1;

        if g == 0
            % βρήκαμε stationnary point
            ak = mid;
            bk = mid;
            ak_list(end+1) = ak;
            bk_list(end+1) = bk;
            break;
        elseif g > 0
            % f' > 0 -> ελάχιστο στα αριστερά
            bk = mid;
        else
            % f' < 0 -> ελάχιστο στα δεξιά
            ak = mid;
        end

        ak_list(end+1) = ak;
        bk_list(end+1) = bk;
    end

    xmin = (ak + bk) / 2;
end