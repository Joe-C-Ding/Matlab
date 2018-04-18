start_tic = tic;
clf;

G = @(x)exp(-(-x).^12);
Ginv = @(G)-(-log(G))^(1/12);

aa = 0.25;
bb = 0.75;
b = Ginv(aa);
a = Ginv(bb) - b;
Gf = @(x)G(a*x+b);

n = 100;
bn = norminv(aa.^(1./n))
an = norminv(bb.^(1./n)) - bn

x = linspace(-5, 10).';
y = (x - an)./bn;
y(y > -b/a) = nan;
F = Gf(y);
plot(x, F);

x = max(randn(n, 1000), [], 1);
ecdf(x);

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));
