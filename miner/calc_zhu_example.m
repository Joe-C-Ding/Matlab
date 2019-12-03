get_ready()

%% prepare
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

[m, c, s2n, n2s] = sn_curve( s, Nf );
k = floor(log10(c));
gamma = mean(std(log(Nf)) ./ mean(log(Nf)));
fprintf('m = %.2f, c = %.2f * 10^%d, gamma = %.4f\n', m, c/10^k, k, gamma);

mu_s = @(s) -m .* log(s) + log(c);
sg_s = @(s) gamma .* mu_s(s);

plot(Nf, s.*ones(size(Nf)), 'x');

xs = linspace(min(s), max(s));
xn = exp(-m * log(xs) + log(c));
plot(xn, xs);

h = gca;
h.XScale = 'log';

set(gcf, 'WindowStyle', 'docked');
%% calc

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
sample = 5e5;

p1 = log(n) - mu_s(s);
p2 = log(n) ./ mu_s(s) .* sg_s(s);

R = [0.9 0.8 0.7 0.6 0.5];
d = cell(length(s), 1);
D = zeros(length(s), length(R));
Ds = zeros(sample, 1);
for i = 1:length(s)
    d{i} = makedist('logn', p1(i), p2(i));
    D(i,:) = d{i}.icdf(R);
    
    Ds = Ds + d{i}.random(sample, 1);
end
sumD = sum(D);
simD = quantile(Ds, R);

num2str([D; sumD; simD], '%.4f\t')

end_up(mfilename)