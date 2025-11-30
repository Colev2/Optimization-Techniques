function [xmin, ak_list, bk_list, fcount] = dichotomy(f, a, b, l, eps)

    if 2*eps >= l
        error("Error: πρέπει να ισχύει 2*eps < l, αλλιώς ο αλγόριθμος δεν τερματίζει.");
    end

    ak = a;
    bk = b;
    ak_list = a;
    bk_list = b;
    fcount = 0;

   
     while (bk - ak) > l

       
        x1 = (ak + bk)/2 - eps;
        x2 = (ak + bk)/2 + eps;

        f1 = f(x1);
        f2 = f(x2);

        fcount = fcount + 2;

      
        if f1 < f2
            bk = x2;   
        else
            ak = x1;   
        end

        ak_list(end+1) = ak;
        bk_list(end+1) = bk;
    end

    xmin = (ak + bk) / 2;

end