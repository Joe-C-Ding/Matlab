get_ready();
%%
Tg = 1.5;
m = 5;

f = 5 / 1344;
stress = 89.4;
distance = 360;

%%
c_damage = stress^m / distance;

str2dist = @(s) (s.^m) ./ c_damage;
dist2str = @(l) (c_damage .* l) .^ (1/m);

L = [40, 60, 100, 160, 360];
[L; dist2str(L)]


k = 2 * norminv(0.9);
sg = log(Tg) ./ k;
[mu,fval,exitflag,output] = fzero(@(mu) logncdf(dist2str(160), mu, sg) - f, log(stress));
if exitflag < 0
    error('cannot solve')
end

fprintf('\nstress: s ~ LogN(mu = %.3f, sigma = %.3f)\n', mu, sg);
df_s = makedist('logn', mu, sg);
pf = [f, 0.01, 0.1, 0.5, 0.9];
sf = df_s.icdf(pf);
[pf; str2dist(sf); sf]

% ln(L) = m ln(S) - ln(c_damage)
mu_l = m * mu - log(c_damage);
sg_l = m * sg;
fprintf('\nmileage: L ~ LogN(mu = %.3f, sigma = %.3f)\n', mu_l, sg_l);
df_l = makedist('logn', mu_l, sg_l);

% [pf; df_l.icdf(pf)]
cov = df_l.std / df_l.mean
cov_ = sg_l / mu_l

df_l.cdf((40:20:300).')
%%
end_up(mfilename);