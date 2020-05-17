get_ready();
%%
Tg = 1.5;
m = 3.5;

f = 2.10 / 100;
stress = 35.1;
distance = 160;

%%
c_damage = stress^m / distance;

str2dist = @(s) (s.^m) ./ c_damage;
dist2str = @(l) (c_damage .* l) .^ (1/m);

L = [40, 60, 100, 160];
[L; dist2str(L)]


k = 2 * norminv(0.9);
sg = log(Tg) ./ k;
[mu,fval,exitflag,output] = fzero(@(mu) logncdf(stress, mu, sg) - f, log(stress));
if exitflag < 0
    error('cannot solve')
end

df_s = makedist('logn', mu, sg)
pf = [0.01, 0.021, 0.1, 0.5, 0.9];
sf = df_s.icdf(pf);
[pf; sf; str2dist(sf)]


%%
end_up(mfilename);