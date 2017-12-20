start_tic = tic;
clf;

N = 1e3;

X = prob.WeibullDistribution(1e4, 2);
% [X.mean X.std]

x = linspace(7e3, 10e3);
s = X.random(x(end), N) .^ (-1.054);

mu = mean(s(:));
sgm = std(s(:));

p = @(x)(x*mu + 1)./(2*x) .* normpdf(1, mu*x, sqrt(x)*sgm);
plot(x, p(x));

s = cumsum(s);
n = zeros(1, N);
for i = 1:N
    n(i) = find(s(:,i) >= 1, 1);
end
histogram(n, 'normalization', 'pdf');

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));