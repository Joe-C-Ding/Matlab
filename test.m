start_tic = tic;
figure(1);
clf; ax = gca;

hold(ax, 'on');
grid(ax, 'on');

p = 5.2;
ret2accrual(p)

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));