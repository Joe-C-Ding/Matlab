start_tic = tic;
clf;

global Du a b l diameter interval POD;
Du = 3;
diameter = 1e10 / pi;
interval = 100e4;

a = 4.8619247030663174e-05;
b = 0.9999972829054025;
l = 104.71435163732492;

POD = xlsread('POD.xls', 2);

phi = @(x) 0.5 + 0.5*erf( x / sqrt(2) );


t = linspace(0, 1e7, 30);
F = Sn(t, @pond, 1)
plot(t, F);

ax = gca;
ax.YScale = 'log';
ylim([1e-40, 1]);

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));