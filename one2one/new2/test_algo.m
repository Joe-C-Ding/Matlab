start_tic = tic;
close all;
clear psn_curve;

a = -20.7843;
b = -1.10607;

loc = 18.2305;
scl = 1.68844;
shp = 2.70123;

dist = 'wbl';
type = 1;

w = prob.WeibullDistribution(scl, shp);
s = [0.95          0.9        0.825         0.75        0.675];

sample = 15;
N = 50;

x = zeros(N, 5);
for i = 1:N
    Nf = w.random(sample, length(s)) + loc;
    Nf = exp(bsxfun(@rdivide, Nf, log(s)-b) + a);

    [~,~,paras,stat] = psn_curve(Nf, s, dist, [1 1], 0, type);
    x(i,1) = paras.B;
    x(i,2) = paras.C;
    x(i,3) = paras.pd.loc;
    x(i,4) = paras.pd.scl;
    x(i,5) = paras.pd.shp;
end
fprintf('bad init: %d (%.0f%%)\n', stat, 100*stat/N);

t = [a b loc scl shp];
for i = 1:5
	subplot(2,3, i);
    histogram(x(:,i));
    plotx(t(i), 'r--');
    
    e = x(:,i)-t(i);
    textbox(gca, sprintf('mean: %.6f\nstd: %.6f\ncoef: %.6f', ...
        mean(e), std(e), std(e)/mean(e)));
end

figure
[U,V,paras] = psn_curve(Nf, s, dist, [1 1], 0, type);
v = reshape(V.ns(Nf, s), [], 1);
[~,~,loc] = wblpwm(v);

subplot(2,2,1);
wblplot(v-loc);

subplot(2,2,2);
ecdf(v);
fplot(@(x)U.v(x), [min(v), max(v)]);

subplot(2,2,3);
f = [0.01 0.1 0.5 0.9 0.99];
plot(Nf, ones(size(Nf,1),1)*s, 'x');

n_plot = logspace(log10(min(Nf(:))), log10(max(Nf(:))));
s_plot = zeros(length(n_plot), length(f));
for i = 1:length(f)
    s_plot(:,i) = U.nf(n_plot, f(i));
end

plot(n_plot, s_plot);
set(gca, 'xscale', 'log');

%%
fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));