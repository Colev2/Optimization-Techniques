    function gamma = gammaMethod(xk, dk, stepType, gamma0)

    fk = objectiveFunction(xk);
    gk = gradientFunction(xk);

    switch lower(stepType)
        case 'constant'
            gamma = gamma0;

        case 'exact'
            phi = @(t) objectiveFunction(xk + t*dk);
            gamma = golden_section(phi, 0, 5, 1e-4); 

        case 'armijo'
            s = gamma0;
            a   = 1e-4;
            beta = 0.5;
            mk = 1;
            gamma = s;

            while objectiveFunction(xk + gamma*dk) > fk + a*gamma*(gk.'*dk)
                gamma =  s * beta^mk;
                if gamma < 1e-12
                    break;
                end
                mk = mk +1;
            end
        
        otherwise
            error('Unknown stepMethod "%s"', stepType);
    end
end