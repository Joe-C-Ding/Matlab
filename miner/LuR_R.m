start_tic = tic;
clf;

isplot = true;
% isplot = false;

b = 2.5;
X = prob.WeibullDistribution(5, b);
Y = prob.WeibullDistribution(10, b);

R = 0:0.1:1;
d = X.icdf(R) + Y.icdf(R);

if isplot
    L = @(u, d)Y.cdf(bsxfun(@minus, d, X.icdf(u)));
    
    u = linspace(0, 1).';
    v = L(u, d);
    
    plot(u, v);
else
    L = @(u)Y.cdf(d - X.icdf(u));
    
    Lud = integral(L, 0, 1, 'ArrayValued', 1);
    plot(R, Lud, [0, 1], [0, 1]);
end

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));