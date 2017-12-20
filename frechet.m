start_tic = tic;
clf;

a = 1;
Fx = @(x) exp(-x.^(-a));
fx = @(x) a*x.^(-1-a) .* Fx(x);
fy = @(y) 0.75*(1 - y.^2);
fxy = @(x,y) fx(x) .* fy(y);

xm = (1/log(2))^(1/a)

p1 = Fx(xm-1)
p2 = integral2(fxy, xm-1, xm+1, -1, @(x)xm-x)
p1 + p2

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));