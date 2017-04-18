start_tic = tic;
gcf;
clf(1); ax = axes('parent', 1);
hold(ax, 'on');
grid(ax, 'on');

x = [
    525 5.33
    500 5.50
    475 5.59
    450 5.82
    400 6.15
];
y = x(:,2);
x = log(x(:,1));

p = polyfit(x, y, 1);
p(1) = -p(1);
p(2) = exp(p(2));
disp(p);


fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));