start_tic = tic;
gcf;
clf(1); ax = axes('parent', 1);
hold(ax, 'on');
grid(ax, 'on');

bond = 10;
x = linspace(-bond, bond);
[X, Y] = meshgrid(x, x);

Z = 100*(Y - X.^2).^2 + (1-X).^2;

h = surf(ax, X, Y, Z);
h.LineStyle = 'none';

[zmin, idx] = min(Z, [], 2);
plot3(x(idx), x, zmin, 'r');

xlabel('X');
ylabel('Y');
zlim([0, 200]);

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));