function x = clamp_to_bounds(x, B)
% Vazei tis times twn genes sta epitrepta oria pou orisa sto bounds_struct.m 
% Eisodoi:
% x: chromosome
% B: struct me ta epitrepta oria twn parametrwn sta dianysmata B.lb, B.ub
x = min(max(x, B.lb), B.ub);
end
