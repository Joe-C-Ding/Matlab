get_ready()
% calc primes dist, and 2 famous estimators.

N = 1000;
p = primes(int32(N)).';

x = linspace(5, N, 1e3);
pix = @(x) sum(bsxfun(@le, p, x), 1);
y = pix(x);
plot(x, y);

lower = x./(log(x)-1);
upper = logint(x) - 1; % that is $\int_0^x dt/ln(t) - 1$.
plot(x, lower, 'r', x, upper, 'k');

figure;
title('errors of esitmator')
plot(x, y-lower, 'r', x, y-upper, 'k');
ylabel('errors');
xlabel('n');

end_up(mfilename)