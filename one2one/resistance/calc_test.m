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

[U, V, paras] = psn_curve(Nf, s, 'Normal', [true, false]);

%% test fitting result.
% i = 5;  %choose a colounm
% N = Nf(:,i);
% ecdf(N);
% n = linspace(0.8*N(1), 1.2*N(end));
% plot(n, U.ns(n, s(i)));

%% test consist of iter and trans
loads = [
    240 1e5
    350 8e4
    400 2.5e4
    500 1e4
    400 2.5e4
    350 8e4
    240 1e5
];
k = size(loads, 1);

h = @(n, p, s) bsxfun(@rdivide, n, U.sf(s, p));
hinv = @(d, p, s) bsxfun(@times, d, U.sf(s, p));
eta = @(d, n, p, s) h(hinv(d, p, s) + n, p, s);

alpha = @(p, s2, s1) U.sf(s1, p) ./ U.sf(s2, p);

p = [0.1 0.5 0.9];

% iterate
d = zeros(k+1, length(p));
n = zeros(k+1, 1);
for i = 1:k
    n(i+1) = n(i) + loads(i, 2);
    d(i+1, :) = eta(d(i, :), loads(i, 2), p, loads(i, 1));
end
plot(n, d, 'x-');

% transfer
s1 = loads(1,1);
coef = eqcoef(p, @(p, s) alpha(p, s, s1), loads);
n_total = sum(loads(:,2));
d = eta(0, coef*n_total, p, s1)
plot([0 n(end)], [d; d], 'k:');

i = 3;
s2 = loads(i,1);
coef = eqcoef(p, @(p, s) alpha(p, s, s2), loads);
d2 = eta(0, coef*n_total, p, s2)

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));