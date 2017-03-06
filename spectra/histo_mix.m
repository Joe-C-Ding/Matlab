start_tic = tic;
figure(1);
clf; ax = gca;

hold(ax, 'on');
grid(ax, 'on');

load norm_weibul.mat;

n = 70;

[N, edges] = histcounts([xn; xw], n, 'normalization', 'pdf');

% ax.XTick = edges;
cedges = (edges(1:end-1) + edges(2:end)) / 2;

x = linspace(edges(1), edges(end), 1e3);
h = plot(ax, x, 0.5*normpdf(x, u, s) + 0.5*wblpdf(x-c, a, b), 'r');
h.LineWidth = 2;
h = plot(ax, cedges, N, 'b');
h.LineWidth = 1.5;

legend({'theoretical', 'empirical'}, 'FontSize', 12)

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));