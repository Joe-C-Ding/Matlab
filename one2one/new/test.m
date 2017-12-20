start_tic = tic;
clf;

x = makedist('Lognormal', 10, 2);
y = makedist('Lognormal', 100, 7);
zp_xy(x, y)

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));