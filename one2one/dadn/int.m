start_tic = tic;
% close all but one figure, or creat one if none is there.
h = get(groot, 'Children');
if length(h) > 1
    i = ([h.Number] == 1);
    close(h(~i)); h = h(i);
end
clf(h);

syms a ac ath m C a0 au positive;

assume(0<ath & ath<a0 & a0<au & au<ac);
f = C * a^(m/2);

n = int(1/f, a, a0, au);
n = simplify(n, 'IgnoreAnalyticConstraints',true);

pretty(n);

clear variables;
fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));