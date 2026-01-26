function x = mutation_gaussian(x, B, mutation_rate, mutation_scale)
% Gaussian mutation ana gene me probability mutation_rate.
% Step size scaled by bounds range.
% Mutation: x(i) = x(i) + N(0,1)*step = x(i) + N(0,step^2) 
% Eisodoi: 
% x: chromosome
% B: struct pou periexei ta oria twn parametrwn
% mutation_rate: Pithanotita metallaxis gia kathe gene
% mutation_scale: Bhma metallaxis
% Epistrefei to mutated chromosome x

range = (B.ub - B.lb);  % euros ths parametrou, p.x gia σ1: range = 1.5 - 0.5 = 1, gia c1: range = 2-(-1) = 3
                        % To mutation vhma ginetai analogika me to euros ths parametrou, dioti gia kathe parametro h idia metavolh exei diaforetikh epirroh.
                        % P.x an c in [-2,2]-> range=4, σ in [0.05,0.2]-> range=1.15, kai x(i)= x(i) + randn*0.1, tote gia to c to 0.1 einai mikrh allagh, enw gia to σ terastia.
                  
for i = 1:numel(x)     % Gia kathe gene
    % Theloume na kanoume metallaxi tou gene me pithanotita mutation _rate. Ara prepei na ftiaksoume ena gegonos, to opoio na symvainei me pithanotita mutation_rate
    % To na metallaxthei ena gene me pithanotita p.x 12%, einai to idio me thn pithanotita enas tyxaios arithmo X~U(0,1) na vrisketai sto (0,0.12) 
    % dioti: Gia to gegonos A={X in (0,0.12)}, exoume P(A)= P(0<X<0.12)= integral(1*dx) in (0,0.12) = 0.12
    % Ara to gegonos rand < mutation_rate, symvainei me pithanotita 0.12 = mutation_rate, opote o algorithmos mpainei mesa sto if me pithanotita mutation_rate,
    % dhladh to gene metallassetai me pithanotita mutation_rate      
    if rand < mutation_rate 
        step = mutation_scale * range(i);
        x(i) = x(i) + randn * step;
    end
end

end
