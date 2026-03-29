function [best_theta, best_hist] = ga_run(U, y, B, ga_params, fit_params)
% Dhmiourgei ena plhthysmo kai ton arxikopoiei me tyxaia xrwmoswmata entos oriwn
% Ypologizei ta fitness values tous
% Dhmiourgei neo plhthysmo ws eksis:
% A) Elitism: Ta prwta k nea xrwmoswmata tha einai autousia ta k kalytera tou paliou plhthysmou
% B) Ta ypoloipa tha einai paidia, ta opoia dhmiourgountai me crossover goniwn + mutation
% Epanaypologizei ta fitness values tou neou plhthysmou
% Apothikeuei to kalytero fitness value pou exei petyxei o algorithmos mexri thn trexousa genia, kai to theta pou thn petyxainei
% Epistrefei to theta (xrwmoswma) poy edwse thn best ever fitness value, kai to dianysma best_hist me th best_fitness value mexri th trexousa genia
K = numel(B.lb) / 4;   % 4K chromosome
D = numel(B.lb);

pop_size = ga_params.pop_size;

% Arxikopoihsh plhthysmou entos twn oriwn

pop = zeros(pop_size, D);       % Kathe grammi, ena atomo (xrwmoswma)
for i = 1:pop_size
    pop(i,:) = B.lb + rand(1,D).*(B.ub - B.lb);         % Tyxaia arxikopoihsh tou plhthysmou: rand(1,D) -> 1xD dianysma me stoixeia ~U(0,1)
                                                        % pop(i,:) : h i grammh pairnei times gonidiwn pou ~U(lb,ub)
end                                                     % Kathe pop(i,:) einai ena dianysma theta=[c11 c12 c13... | c21 c22 c23 ... | σ11 σ12 σ13 ... | σ21 σ22 σ23 ...]

% Initial fitness
fit = zeros(pop_size,1);        % fit: dianysma (pop_size x 1)
for i = 1:pop_size
    fit(i) = fitness(U, y, pop(i,:), K, fit_params);    % Kalw thn fitness kai ths dinw ws theta to chromosome pop(i,:). 
                                                        % Epistrefei to fitness value tou, kai to anathetw sto fit(i): fit(i)= [J(theta_1) J(theta_2) J(theta_3) ... J(theta_pop_size)]^T
end

% Global best initialization 
[fit_sorted, order] = sort(fit, 'ascend');      % Taxinomhse ta fit me auksousa seira. Apothekeuse tes sto dianysma fit_sorted (pop_size x 1), kai tous deiktes tous sto dianysma order 
best_fit_global   = fit_sorted(1);              % To prwto stoixeio tou fit tha exei thn elaxisth fitness value, ara thn kalyterh
best_theta_global = pop(order(1),:);            % order(1): To deikth tou atomou me thn kalyterh fitness value. 
                                                % pop(order(1),:) : To xrwmoswma pou dinei thn elaxisth fitness value. 

best_hist = zeros(ga_params.generations,1);     % Dianysma generations x 1, pou tha krataei thn kalyterh fitness value se kathe genia. 

% GA generations

for gen = 1:ga_params.generations

    % Sort by fitness (ascending)
    [~, order] = sort(fit, 'ascend');
    pop_sorted = pop(order,:);                  % Anakatatassei ton plhthysmo vazontas ta xrwmoswmata me auxousa seira ws pros to fitness value

    % Elitism: keep few of the best chromosomes in the new population
    new_pop = zeros(size(pop));
    elite_count = ga_params.elite_count;
    new_pop(1:elite_count,:) = pop_sorted(1:elite_count,:);     % Ta 3 (p.x) prwta stoixeia tou neou plythsmou new_pop tha einai ta xrwmoswmata tou 
                                                                % paliou plhthysmou me tis 3 kalyteres fitness values

    % O ypoloipos neos plhthysmos tha einai ta paidia
    for i = elite_count+1 : pop_size

        % Epilogh 2 goniwn
        p1_idx = selection_tournament(fit, ga_params.tournament_size);
        p2_idx = selection_tournament(fit, ga_params.tournament_size);

        p1 = pop(p1_idx,:);
        p2 = pop(p2_idx,:);

        % Crossover goniwn gia dhmiourgia paidiou
        if rand < ga_params.crossover_rate      % Kane crossover me pithanotita crossover_rate (p.x 0.9)
            child = crossover_blx(p1, p2, ga_params.blx_alpha);
        else
            child = p1;     % alliws to paidi tha einai o prwtos gonios
        end

        % Mutation paidiou
        child = mutation_gaussian(child, B, ga_params.mutation_rate, ga_params.mutation_scale);

        % Clip
        child = clamp_to_bounds(child, B);     % Gia na ksanampoun sta epitrepta oria ta genes twn paidiwn

        new_pop(i,:) = child;       % Prosthetw to paidi ston neo plhthysmo
    end
    
    % O new_pop periexei twra tous 3 (p.x) kalyterous gonious kai (pop_size - 3) paidia

    % Replace population
    pop = new_pop;

    % Ksana ypologizw fitness gia to neo plhthysmo
    for i = 1:pop_size
        fit(i) = fitness(U, y, pop(i,:), K, fit_params);
    end

    % Update global best (NEW)
    [fit_sorted, order] = sort(fit, 'ascend');
    if fit_sorted(1) < best_fit_global      % An h kalyterh fitness value tou neou plhthysmou einai kalyterh apo tou paliou
        best_fit_global   = fit_sorted(1);  % pare authn ws kalyterh
        best_theta_global = pop(order(1),:); % kai to theta (chromosome) pou thn dinei 
    end                                      % Alliws, h genia auth edwse xeirotero best_fitness value apo oti h palia, opote krata thn palia ws best_ever (global).

    % Apothikeush twn best_fit_global gia plot
    best_hist(gen) = best_fit_global;    % Krataei ta best_fit_global dhladh thn kalyterh fitness value pou eixame MEXRI kai thn trexousa genia
                                         % (an h best fitness value ths trexousas genias einai xeiroterh thn petaei, giati mas endiaferei h kalyterh lysh pou eixame ston algorithmo)

    % Output 
    if mod(gen, 40) == 0
        fprintf('Generation %d/%d | best fitness value = %.6f\n', gen, ga_params.generations, best_hist(gen));
    end
end

% Epestrepse to theta pou edwse thn kalyterh fitness value
best_theta = best_theta_global;

end
