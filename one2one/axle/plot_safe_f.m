start_tic = tic;
close all

%%
Tg = [1.2 1.3 1.4];
lt = ["k:", "k--", "k-."];
stress = 240;

mu = log(stress);
sg = log(Tg)/norminv(0.9)/2;

sq = [1.2 1.33 1.5 1.66];
fq = zeros(length(Tg), length(sq));
h = zeros(size(Tg));
for i = 1:length(Tg)
    s = linspace(1, 2);
    f = logncdf(stress./s, mu, sg(i));
    h(i) = plot(s, f, lt(i));

    f = logncdf(stress./sq, mu, sg(i));
%     plot(sq, f, 'kd');
    fq(i,:) = f;
end
[sq' fq']
legend(h, ["$T_g=1.2$", "$T_g=1.3$", "$T_g=1.4$"], 'location', 'SW');

h = gca;
h.YScale = 'log';
ylim([1e-15 1])
yt = flip([50 0.1 1e-5 1e-9 1e-13]);
yl = strsplit(num2str(yt, '%1.2g\n'));
yticks(yt/100);
yticklabels(yl);

xticks([1 sq 2]);
% xtickangle(45);

h.XMinorGrid = 'off';
h.YMinorGrid = 'off';

xlabel('safety factor')
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