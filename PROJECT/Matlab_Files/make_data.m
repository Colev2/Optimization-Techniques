function [Utr,ytr, Uval,yval, Ute,yte] = make_data(Ntr, Nval, Nte)

u1_min = -1; u1_max = 2;
u2_min = -2; u2_max = 1;

% Train Data
Utr  = [u1_min+(u1_max-u1_min)*rand(Ntr,1), u2_min+(u2_max-u2_min)*rand(Ntr,1)];
ytr  = true_f(Utr(:,1), Utr(:,2));

% Validation Data
Uval = [u1_min+(u1_max-u1_min)*rand(Nval,1), u2_min+(u2_max-u2_min)*rand(Nval,1)];
yval = true_f(Uval(:,1), Uval(:,2));

% Test Data
Ute  = [u1_min+(u1_max-u1_min)*rand(Nte,1), u2_min+(u2_max-u2_min)*rand(Nte,1)];
yte  = true_f(Ute(:,1), Ute(:,2));
end
