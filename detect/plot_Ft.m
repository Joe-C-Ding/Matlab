start_tic = tic;
close all

load Ft_up_lo.mat

hl = plot(t, F(:,1), 'k--', t, F(:,2), 'k-.');
legend(hl, {'upper', 'lower'}, 'location', 'SE');

h = gca;
xlabel('$t$');
ylabel('$F(t)$');
h.YScale = 'log';
h.YLim = [1e-40 1];
h.YTick = 10.^[-40 -30 -20 -10 0];

grid off

%%
fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));

figure(1);
if strncmpi(mfilename, 'plot_', 5)
    pname = mfilename;  % mfilename(6:end) wont work.
    print(pname(6:end), '-depsc');
else
    set(1, 'windowstyle', 'docked')
end