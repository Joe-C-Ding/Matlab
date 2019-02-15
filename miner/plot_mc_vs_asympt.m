start_tic = tic;
clf;

%%
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
[m, log10(C), gamma]
clear A b;

% x = logspace(5, 6.5);
% y = (C./x).^(1/m);
% plot(x, y);
% plot(Nf, s, 'x');
% set(gca, 'XScale', 'log');
clear x y s Nf

Ns = @(s) C./s.^m;

%%
spct = [
    200 1e6
    250 8e5
    300 2.5e5
    350 1e5
    400 5e4
    450 1e4
];

s = spct(:,1);
n = spct(:,2);
sumn = sum(n);

Nf = Ns(s);
mu = log(Nf);
sgm = gamma * log(Nf);
dmu = log(n) - mu;
dsgm = sgm .* log(n)./mu;

R = [0.9 0.8 0.5];

%% miner
Nr = zeros(length(s), length(R));
for i = 1:length(s)
    Nr(i,:) = logninv(1-R, mu(i), sgm(i));
end
dm = bsxfun(@rdivide, n, Nr);
Dm = sum(dm)

%% mine
d = zeros(length(s), length(R));
for i = 1:length(s)
    d(i,:) = logninv(R, dmu(i), dsgm(i));
end
d;
D = sum(d)

%% answer
sample = 1e4;
dmc = zeros(length(s), sample);
for i = 1:length(s)
    dmc(i,:) = lognrnd(dmu(i), dsgm(i), 1, sample);
end
Dmc = sum(dmc);
[f, x] = ecdf(Dmc);
Dmc = interp1(f, x, R)

%% approx & plot
[m,v] = lognstat(dmu, dsgm);
sum_mu = sum(m);
sum_sgm = sqrt(sum(v));

plot(x, f, 'k');
plot(x, normcdf(x, sum_mu, sum_sgm), 'k:');
xlim([min(x), 0.4]);
legend('Monte-Carlo', 'asympt', 'location', 'se')
xlabel('$D$')
ylabel('$R$')

%%
fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));

figure(1);
if strncmpi(mfilename, 'plot_', 5)
    pname = mfilename;  % mfilename(6:end) wont work.
    print(pname(6:end), '-depsc');
else
    set(1, 'windowstyle', 'docked')
end