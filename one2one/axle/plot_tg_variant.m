start_tic = tic;
% close all but one figure, or creat one if none is there.
h = get(groot, 'Children');
if length(h) > 1
    i = ([h.Number] == 1);
    close(h(~i)); h = h(i);
end
clf(h);

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
yt = flip([50 10 1 0.1 1e-3 1e-5 1e-7 1e-10]);
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

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));