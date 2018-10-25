start_tic = tic;
% close all but one figure, or creat one if none is there.
h = groot; h = h.Children;
if length(h) > 1
    i = ([h.Number] ~= 1);
    close(h(i)); h = h(~i);
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
d0 = 0;
n = 5e4;

Nf = Ns(s)
mu = log(Nf);
sgm = gamma * mu;
N = makedist('lognormal', mu, sgm);

hp = @(n,p) bsxfun(@rdivide, n, N.icdf(p));
hpinv = @(d,p) bsxfun(@times, d, N.icdf(p));

d_n = @(n,p) hp(hpinv(d0,p)+n, p);
n_d = @(d,p) hpinv(d,p) - hpinv(d0,p);

Fd = @(d, n) 1-N.cdf(bsxfun(@rdivide, n, d));
Fn = @(n, d) N.cdf(bsxfun(@rdivide, n, d));

d = linspace(-1, 3);
n = [5e5 1e6 2e6];
ltype = ["k--", "k-.", "k"];
for i = 1:length(n)
    cdf = Fd(d, n(i));
    pdf = diff(cdf)./diff(d);
    pdf(pdf < 1e-3) = nan;
    plot(d(2:end-1), pdf(2:end), ltype(i));
end

% ylim([0 0.8]);
xlabel('$D$');
ylabel('$f_D(d|n)$');

legend({'$n=0.5\times10^6$', ...
    '$n=\hphantom{0.}1\times10^6$', '$n=\hphantom{0.}2\times10^6$'},...
    'Location', 'NE');

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));