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
Tg = 1.3;

U = getU(sb, Nb, Tg);
n = logspace(5, 8).';
p = [0.01 0.1 0.5 0.9 0.99];
plot(n, U.nf(n, p));

h = gca;
h.XScale = 'log';
h.YScale = 'log';

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));