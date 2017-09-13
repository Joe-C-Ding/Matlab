start_tic = tic;
close all;
% gcf; clf(1);
% ax = axes('parent', 1);
% hold(ax, 'on'); grid(ax, 'on');

d = linspace(0, 1);

mu = 1000;
sg = 20;
n = mu / 10;

t0 = 900;
[a, b] = norm2wbl(mu-t0, sg);

t = prob.NormalDistribution(mu, sg);
M = 1 - t.cdf(n./d);

t = prob.NormalDistribution(n/mu, sg/mu * n/mu);
O = t.cdf(d);
plot(d, M-O);

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));