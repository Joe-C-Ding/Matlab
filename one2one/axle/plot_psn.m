start_tic = tic;
close all;

p = [0.1 0.5 0.9];
Tg = 1.4;

U = getU(180, 1e7, Tg, 5, 8);

N = logspace(5, 8);
s = U.nf(N.', p);
plot(N, s(:,1), 'k--', N, s(:,2), 'k', N, s(:,3), 'k-.');

legendv(p, '%.1f', 'p');

h = gca;
h.XScale = 'log';
xlabel('$N$');
% xticks(10.^[9 10 11 12 13]);

h.YScale = 'log';
ylabel('$S$');
ylim([100 540]);

grid off;

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));

figure(1);
if strncmpi(mfilename, 'plot_', 5)
    pname = mfilename;  % mfilename(6:end) wont work.
    print(pname(6:end), '-depsc');
else
    set(1, 'windowstyle', 'docked')
end