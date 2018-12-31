start_tic = tic;
close all

Tg = [1.2 1.3 1.4];
lt = ["k:", "k--", "k-."];
stress = 240;

mu = log(stress);
sg = log(Tg)/norminv(0.9)/2;

f = logspace(-12, 0);
fp = logninv(f);
for i = 1:length(Tg)
    s = logninv(f, mu, sg(i));
    plot(s, fp, lt(i));
end
legend({'$T_g=1.2$', '$T_g=1.3$', '$T_g=1.4$'}, 'location', 'NW');

h = gca;
h.YScale = 'log';
yt = flip([50 10 1 1e-2 1e-5 1e-7 1e-10]);
yl = strsplit(num2str(yt, '%1.2g\n'));
yt = logninv(yt./100, 0, 1);
yticks(yt);
yticklabels(yl)
ylim(yt([1 end]))

h.XScale = 'log';
sq = flip([1.2 1.33 1.5 1.66]);
xt = [100 240./sq 240];
xl = strsplit(num2str(xt, '%.0f\n'));
xticks(xt)
xticklabels(xl)
xtickangle(45);
xlim([100 250])

h.XMinorGrid = 'off';
h.YMinorGrid = 'off';

xlabel('stress/MPa')
ylabel('failure/\%')

%%
fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));

figure(1);
if strncmpi(mfilename, 'plot_', 5)
    pname = mfilename;  % mfilename(6:end) wont work.
    print(pname(6:end), '-depsc');
else
    set(1, 'windowstyle', 'docked')
end