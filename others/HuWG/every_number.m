start_tic = tic;

p = perms(1:9);

digit = 10 .^ (0:8);
a = sum(bsxfun(@times, p, digit), 2);
c = mod(a, 1e4);
a = floor(a / 1e4);
b = mod(a, 10);
a = floor(a / 10);

i = abs(a.*b - c) < eps;
fprintf('%d * %d = %d\n', [a(i), b(i), c(i)]');

t = mod(a, 10);
a = floor(a / 10);
b = 10*t + b;

i = abs(a.*b - c) < eps;
fprintf('%d * %d = %d\n', [a(i), b(i), c(i)]');

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));