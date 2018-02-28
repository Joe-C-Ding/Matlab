start_tic = tic;
clf;

rs = 0.8;
nu = .5;
X = prob.tLocationScaleDistribution();
X.nu = nu;

Lur = @(u, r, rs)X.cdf((1+rs)*X.icdf(r) - rs*X.icdf(u));
Lr = @(r, rs)integral(@(u)Lur(u, r, rs), 0, 1);
Lrv = @(r, rs)integral(@(u)Lur(u, r, rs), 0, 1, 'ArrayValued', 1);

r = linspace(0, 1, 30);
s = Lrv(r, rs);
plot(r, s)
plot([0 1], [0 1], [Rmax Rmax], [0, Rmax], 'k--');
ht = text(Rmax-.02, Rmax, sprintf('%.4f', Rmax));
ht.HorizontalAlignment = 'right';

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));