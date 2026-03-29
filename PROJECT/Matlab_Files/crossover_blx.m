function child = crossover_blx(p1, p2, alpha)
% BLX-alpha crossover
% Dhmiourgei paidia
% p1: parent 1  (1x60)
% p2: parent 2  (1x60)
% alpha: stathera pou orizei poso eksw apo ta oria twn goniwn mporei to paidi na dhmiourgithei 
% parents: range gia to gene i: [min(i), max(i)] -> child: sample uniformly from [min(i) - alpha*d(i), max(i) + alpha*d(i)], dhladh kathe paidi~U(min-a*d, max + a*d)

mins = min(p1, p2);
maxs = max(p1, p2);
d = maxs - mins;

low = mins - alpha .* d;
high = maxs + alpha .* d;

r = rand(size(p1));     % r: 1x60 dianysma me stoixeia sto (0,1) pou akolouthoun U(0,1)
child = low + r .* (high - low);    % child = [low1 + r1(high1-low1), low2 + r2(high2-low2), ...] = [..., min(p1(i),p2(i))-ad + r(1+2a)d(i) ,...] 

% P.x: 
% p1 = [1 3 7 2], p2 = [2 2 5 4], a=0.3
% mins = [1 2 5 2], maxs = [2 3 7 4]
% d = [1 1 2 2] 
% low = [0.7 1.7 4.4 1.4], high = [2.3 3.3 7.6 4.6]
% high-low = [1.6 1.6 3.2 3.2]
% r = [0.1 0.6 0.4 0.8]
% child = [0.86 2.66 5.68 4.56], vlepoume oti to paidi pairnei kai times genes ektos twn oriwn twn goniwn
end
