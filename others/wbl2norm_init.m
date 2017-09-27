start_tic = tic;
close all;

needplot = false;

a = linspace(1, 1000);
b = linspace(1.1, 100);
[A, B] = meshgrid(a, b);
[M, V] = wblstat(A, B);

A = A(:);
B = B(:);
M = M(:);
V = V(:);

[surffit,gof] = fit([A, B], M, 'poly11')
m = coeffvalues(surffit);
if needplot
    figure;
    plot(surffit, [A, B], M);
    figure;
    plot(surffit, [A, B], M, 'style', 'Residuals');
end

[surffit,gof] = fit([A, B], V, 'poly11')
v = coeffvalues(surffit);
if needplot
    figure;
    plot(surffit, [A, B], V);
    figure;
    plot(surffit, [A, B], V, 'style', 'Residuals');
end

A = [m(2:3);mv(2:3)];
b = [m(1), v(1)].';

A = inv(A);
b = A * b;
[A b]

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));