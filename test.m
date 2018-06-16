start_tic = tic;
clf;

p = linspace(eps, 1);

y1 = log(1+p);
y2 = p;
plot(p, y1, 'r', p, y2);


fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));
