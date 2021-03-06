start_tic = tic;
clf;
h = gca;
xlim([0 1]); h.XTick = 0:0.2:1;
ylim([0 1]); h.YTick = 0:0.2:1;

a = 10; b = 2;
pd = prob.NormalDistribution();

conf = 0.8;
z = pd.icdf(1-conf);

x = linspace(0, 1, 1e3);
X = pd.icdf(1-x);
Y = 2*z - X;
y = 1-pd.cdf(Y);
y(end) = 0;

fill( ... % C
    [x, 1, conf, conf, 0, 0], ...
    [y, 0, 0, conf, conf, 1], ...
    156/256 * [1 1 1], 'LineStyle', 'none' ...
);
fill( ... % D
    [x, 1, 1, conf, conf, 0], ...
    [y, 0, conf, conf, 1, 1], ...
    207/256 * [1 1 1], 'LineStyle', 'none' ...
);

plot([conf conf], [0 1], 'r--');
plot([0 1], [conf conf], 'r--');
hxy = plot(x, y, 'b');

grid off;
h = legend(hxy, '$x+y=d_{0.8}$');
h.Location = 'southwest';
h.FontSize = 12;
xlabel('$u$'); ylabel('$v$');

text(0.4, 0.4, '$A$');
text(0.9, 0.9, '$B$');

text(0.6, 0.85, '$C$');
text(0.7, 0.93, '$D$');
text(0.88, 0.58, '$C''$');
text(0.93, 0.7, '$D''$');

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));