start_tic = tic;
clf;

a = 2;
t = sqrt(a);

f = @(x)x/2 + a/2/x;
g = @(x)f(x) - (x^2-a)^2/(2*x)^3;

N = 10;
x = 10; y = 10;
r = zeros(N, 4);
for i = 1:N
    x = f(x);
    y = g(y);
    r(i,:) = [x, abs(x-t), y, abs(y-t)];
end
r

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));