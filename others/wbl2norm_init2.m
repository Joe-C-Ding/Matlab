start_tic = tic;
close all;

b = linspace(1, 50)';
f = @(x)gamma(1 + 1./x);
m = f(b);
plot(b, m);

x = fminbnd(f, 1, 6)   % x ~= 2.1662

b = linspace(0.1, x)';
m = f(b);
s = fit(1./b, log(m), 'poly1')
figure;
plot(s, 1./b, log(m));

b = linspace(x, 100)';
m = f(b);
s = fit(1./b, m, 'poly1')
figure;
plot(s, 1./b, m);

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));