start_tic = tic;
clf;

a = 1e4;
b = [2, 3, 4];
lb = length(b);

N = cell(lb, 1);
s = cell(lb, 1);
for i = 1:lb
    X = prob.WeibullDistribution(a, b(i));
    N{i} = X;
%     fplot(@X.pdf(x), [0, 2e4]);

    x = linspace(eps, 0.001);
    plot(x, X.pdf(1./x));
    
    sk = 1./X.random(1e4, 500);
    s{i} = sprintf('$\\beta = %d$, skew${}= %.2f$'...
        , b(i), mean(skewness(sk)));
end
legend(s, 'interpreter', 'latex');


fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));