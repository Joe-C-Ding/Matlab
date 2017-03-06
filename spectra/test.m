start_tic = tic;
figure(1);
clf; ax = gca;

hold(ax, 'on');
grid(ax, 'on');

a = 33.871901686188274;
b = 2.101349094688545;
c = 20;


% [mu si] = wblstat(a, b);
% [mu+c, sqrt(si)]

func = @(x)wblpdf(x-c, a, b) ./ sncurve(x);
k = integral(func, 20, inf);
x = linspace(0, 150);
plot(ax, x, func(x)/k, 'r');
plot(ax, x, wblpdf(x-c, a, b));

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));