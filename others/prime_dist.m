start_tic = tic;
% close all but one figure, or creat one if none is there.
h = get(groot, 'Children');
if length(h) > 1
    i = ([h.Number] == 1);
    close(h(~i)); h = h(i);
end
clf(h);

N = 1000;
p = primes(int32(N)).';

x = linspace(5, N, 1e3);
pix = @(x) sum(bsxfun(@le, p, x), 1);
y = pix(x);
plot(x, y);

lower = x./(log(x)-1);
upper = logint(x) - 1;
plot(x, lower, 'r', x, upper, 'k');

figure;
plot(x, y-lower, 'r', x, y-upper, 'k');

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));