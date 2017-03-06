start_tic = tic;
ax = cla('reset');

u1 = 90;
s1 = 5;

u2 = 120;
s2 = 10;

k = 0.6;

p = @(x)(k*normpdf(x, u1, s1) + (1-k)*normpdf(x, u2, s2));
% S = integral(p, -inf, inf)

x = linspace(50, 200, 1e3);
plot(ax, x, p(x), 'r'); hold on;

N = 1e4;
X = [normrnd(u1, s1, k*N, 1); normrnd(u2, s2, (1-k)*N, 1)];
h = histogram(ax, X, 'Normalization', 'pdf');

E = zeros(h.NumBins, 1);
edges = h.BinEdges;
for i = 1:h.NumBins
    E(i) = (edges(i)+edges(i+1))/2;
end
plot(ax, E, p(E), 'bx');

toc(start_tic);