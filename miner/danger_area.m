start_tic = tic;
clf;
h = gca;
xlim([0 1]); h.XTick = 0:0.2:1;
ylim([0 1]); h.YTick = 0:0.2:1;

a = 10; b = 2;
pd = prob.tLocationScaleDistribution(0, a, b);

conf = 0.8;
plot([conf conf], [0 1], 'r--');
plot([0 1], [conf conf], 'r--');

z = pd.icdf(1-conf);

x = linspace(0, 1, 1e3);
X = pd.icdf(1-x);
Y = 2*z - X;
y = 1-pd.cdf(Y);
plot(x, y);

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));