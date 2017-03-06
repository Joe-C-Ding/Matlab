start_tic = tic;
figure(1);
clf; ax = gca;

hold(ax, 'on');
grid(ax, 'on');

mu = 50;
sigma = 15;
pd = makedist('normal', mu, sigma);

N = 100;
x0 = 50;
h = 3.5*sigma / N^(1/3);

xa = x0-h/2;
xb = x0+h/2;

pbar = (pd.cdf(x0+h/2) - pd.cdf(x0-h/2))/h;

x = normrnd(mu, sigma, N, 10000);
n = sum(x >= xa & x <= xb);

[cnt, edg] = histcounts(n, 'normalization', 'pdf');
cedges = (edg(1:end-1) + edg(2:end)) / 2;
plot(ax, cedges, cnt, 'o');

ax.XTick = edg;
ax.XTickLabelRotation = 45;

x = floor(min(n)):floor(max(n));
np = N * pbar * h;
y = normpdf(x, np, sqrt(np*(1-pbar*h)));
plot(ax, x, y);

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));