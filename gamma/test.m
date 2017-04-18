start_tic = tic;
clf(gcf); ax = axes('parent', gcf);
hold(ax, 'on');
grid(ax, 'on');

pa = makedist('exp', 1/0.05);
a = trunc_rnd(pa, 0, 34, 5000);

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));