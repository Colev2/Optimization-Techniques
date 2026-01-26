function idx = selection_tournament(fitness_vals, tournament_size)
% Pairnei ola ta fitness values twn atomwn tou plhthysmou, pairnei tournament_size (p.x 2) apo autous, 
% sygkrinei ta fitness values tous, krataei ton kalytero apo tous 2 kai ton epistrefei. 
% Kaleitai 2 fores gia th dhmiourgia 2 goniwn.
% Eisodoi:
% fitness_vals: Nx1 dianysma, me kathe stoixeio na einai h fitness value enos atomou (chromosome)
% tournament_size: Plithos atomwn pou epilegoume apo ton plhthysmo gia sygkrish
% Epistrefei to index tou atomou me thn kalyterh (elaxisth) fitness value metaxy twn 2 (p.x) atomwn pou sygkrine, p.x to atomo 7. 

n = numel(fitness_vals);
cand = randi(n, [tournament_size, 1]);
[~, best_local] = min(fitness_vals(cand)); % minimize fitness
idx = cand(best_local);
end
