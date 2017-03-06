start_tic = tic;
figure(1);
clf; ax = gca;

hold(ax, 'on');
% grid(ax, 'on');

m = [4.0, 3.5, 3.0, 3.0, 3.0, 3.0, 3.0, 3.0];
c = [1.01e15, 4.23e13, 1.52e12, 1.04e12, 0.63e12, 0.43e12, 0.25e12, 0.16e12];

x = logspace(4, 9);
y = zeros(size(x));

k = [5e6, 1e8];
s = cell(size(m));
z = cell(size(m));

for i = 1:length(m)
    m1 = m(i);
    m2 = 2*m1 - 1;
    c0 = c(i);
    c1 = (c0 / k(1))^(m2 / m1) * k(1);
    c2 = (c1 / k(2))^(1 / m2);
    
    y(x <= k(1)) = (c0./x(x < k(1))) .^ (1/m1);
    y(x > k(1) & x <= k(2)) = (c1./x(x > k(1) & x <= k(2))) .^ (1/m2);
    y(x > k(2)) = c2;
    
    plot(ax, x, y, 'linewidth', 2);
    
    s{i} = sprintf('$m$=%.1f, $\\lg{C}$=%.2f', m(i), log10(c(i)));
    z{i} = sprintf('$\\sigma_s$=%.1f', c2);
end
h = legend(s, 'FontSize', 12);
h.Interpreter = 'latex';

plot(ax, [k(1) k(1)], [10 1000], 'k--');
plot(ax, [k(2) k(2)], [10 1000], 'k--');

ax.XScale = 'log';
ax.YScale = 'log';
ax.XLim = [x(1), x(end)];
ax.YLim = [10, 1000];

ax.YTick = logspace(1, 3, 5);
ax.YTickLabel = {'10', '50', '100', '500', '1000'};

xlabel(ax, 'number of cycles $N$', 'Interpreter', 'latex');
ylabel(ax, '$\Delta\sigma$ (MPa)', 'Interpreter', 'latex');

h = textbox(ax, z, 'SW');
h.Interpreter = 'latex';
h.FontSize = 12;

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));