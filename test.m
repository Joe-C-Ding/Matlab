start_tic = tic;
gcf;
clf(1); ax = axes('parent', 1);

hold(ax, 'on');
grid(ax, 'on');



fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));