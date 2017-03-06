start_tic = tic;
figure(1);
clf; ax = gca;

hold(ax, 'on');
grid(ax, 'on');

x = 50000;
p = [4.5 6];
yr = (0:1:50)';

y = bsxfun(@power, (1 + p./100), yr);
y(mod(yr, 10) == 0, :)

plot(yr, y);
legend(num2str(p(:)), 'Location', 'NW');


fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));