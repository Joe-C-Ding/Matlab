start_tic = tic;
% close all but one figure, or creat one if none is there.
h = get(groot, 'Children');
if length(h) > 1
    i = ([h.Number] == 1);
    close(h(~i)); h = h(i);
end
clf(h);

sb = 180;
Nb = 1e7;
Tg = 1.4;

U = getU(sb, Nb, Tg, 5, inf);
p = [0.1 0.5 0.9];
N = logspace(5, 8);
s = U.nf(N.', p);
plot(N, s);

legendv(p, '%.1f', 'p');

h = gca;
h.XScale = 'log';
xlabel('$N$');
% xticks(10.^[9 10 11 12 13]);

h.YScale = 'log';
ylabel('$S$');
ylim([100 540]);

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));