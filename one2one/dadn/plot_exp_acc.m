start_tic = tic;
% close all but one figure, or creat one if none is there.
h = get(groot, 'Children');
if length(h) > 1
    i = ([h.Number] == 1);
    close(h(~i)); h = h(i);
end
clf(h);

%% prepare data
s = [525 500 475 450 400];
Nf = 10.^[
    4.8615	5.0237	5.2391	5.3522	5.7547
    5.0126	5.0846	5.2949	5.4595	5.8529
    5.1059	5.1427	5.3469	5.4929	5.9830
    5.1358	5.3079	5.3508	5.5013	5.9874
    5.1655	5.5103	5.4366	5.7822	6.0614
    5.3461	5.5403	5.6690	5.8874	6.2864
    5.5478	5.6652	5.8075	6.1497	6.2985
    5.6580	5.8491	5.8693	6.1679	6.4020
    5.6658	5.9033	5.9126	6.1715	6.4062
    5.7712	5.9253	5.9787	6.2305	6.4996
];
s = ones(size(Nf, 1), 1) * s;
gamma = mean(std(log(Nf))./ mean(log(Nf)));

b = -log(Nf(:));
A = [log(s(:)), -ones(numel(Nf), 1)];
x = A\b;
m = x(1);
C = exp(x(2));
% [m, log10(C), gamma]
clear A b;
clear x y s Nf

Ns = @(s) C./s.^m;

%%
s = 400;
n = 5e4;

Nf = Ns(s);
mu = log(Nf);
sgm = gamma * mu;
N = makedist('lognormal', mu, sgm);

C = 1e-12 * pi;
h = @(n) exp(C*s^2*n);
hinv = @(d) reallog(d)/C/s^2;

d_d0n = @(d0, n) h(bsxfun(@plus, hinv(d0), n));
n_d0d = @(d0, d) hinv(d) - hinv(d0);
d0_dn = @(d, n) h(bsxfun(@minus, hinv(d), n));

R = [0.1 0.5 0.9];
d0 = d0_dn(1, N.icdf(R));
n = linspace(0, 5*Nf).';
d = d_d0n(d0, n);
plot(n, d, 'k');

ylim([0 2]);
xticks(Nf * (0:0.5:4));
xticklabels((0:0.5:4))
xlabel('$N/N_s$');
ylabel('$D$');

%%
ax = linspace(N.icdf(0.01), N.icdf(0.95));
ay = N.pdf(ax);
k = 0.7/max(ay);
ay = k*ay + 1;
plot(ax, ay, 'k--');
plot(ax([1 end]), [1 1], 'k:');

%%
ht = text(1.66*Nf, 1.43, '$N\sim LN(14.2,0.78)$');
ht.VerticalAlignment = 'middle';
ht.HorizontalAlignment = 'left';
ht.BackgroundColor = 'w';
% ht.FontSize = 12;

ht = text(1.15*Nf, 1.95, '$P=0.1$');
ht.VerticalAlignment = 'top';
ht.HorizontalAlignment = 'right';
% ht.BackgroundColor = 'w';

ht = text(1.95*Nf, 1.95, '$P=0.5$');
ht.VerticalAlignment = 'top';
ht.HorizontalAlignment = 'left';

ht = text(2*Nf, 0.5, '$P=0.9$');
ht.VerticalAlignment = 'top';
ht.HorizontalAlignment = 'left';

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));