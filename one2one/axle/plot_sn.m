start_tic = tic;
close all

%%
sb = 240;
Nb = 1e7;
Tg = 1.4;

p = 0.5; 

U = getU(sb, Nb, Tg, 5, inf);
N = logspace(6, 8);
s = U.nf(N.', p);
plot(N, s, 'k');

N = logspace(7, 8);
U = getU(sb, Nb, Tg, 5, 8);
s = U.nf(N.', p);
plot(N, s, 'k-.');

U = getU(sb, Nb, Tg, 5, 5);
s = U.nf(N.', p);
plot(N, s, 'k:');

legend({"Miner","Hibatch","Corten/Dolan"}, 'location', 'sw')

h = gca;
h.XScale = 'log';
xlabel('$\log N$/cycle');
% xticks(10.^[9 10 11 12 13]);

h.YScale = 'log';
ylabel('$\log S$/MPa');
ylim([140 400]);
yticks([150 240 400]);

grid off;

x1 = 2e6;
y1 = 260;
x2 = U.sf(y1,0.5);
y2 = U.nf(x1(1),0.5);

[xp, yp] = abs2rel(gca, [x1 x1], [y2 y1]);
annotation('line', xp, yp, 'linestyle', '--');
[xp, yp] = abs2rel(gca, [x1 x2], [y1 y1]);
annotation('line', xp, yp, 'linestyle', '--');

h = text(x1-1.5e5, sqrt(y1*y2), '1');
h.HorizontalAlignment = 'right';
h = text(sqrt(x1*x2), y1, '$m$');
h.VerticalAlignment = 'top';

h = textarrow(gca, [1.5e7 1e7], [270 245], '$(N_a, \sigma_a)$');
% h.HorizontalAlignment = 'center';
% h.VerticalAlignment = 'top';

%%
fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));

figure(1);
if strncmpi(mfilename, 'plot_', 5)
    pname = mfilename;  % mfilename(6:end) wont work.
    print(pname(6:end), '-depsc');
else
    set(1, 'windowstyle', 'docked')
end