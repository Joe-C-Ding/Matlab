get_ready(true)

%%
x = linspace(0, 1).';
plot([0, 1], [1, 0], 'k');

a = 0.4;
N = 0.08;

yc = 1 - x .^ (N .^ a);

xk = 0.35 * N .^ 0.25;
yk = 0.65 * N .^ 0.25;

yl = zeros(size(x));
f1 = @(x) x * (yk - 1) / xk + 1;
f2 = @(x) (x - 1) * yk / (xk - 1);
yl(x < xk) = f1(x(x < xk));
yl(x > xk) = f2(x(x > xk));

plot(x, yl, 'k--', x, yc, 'k-.');

legend({'linear', 'double linear', 'non-linear'})

xlabel('Applied cycle ratio, $n_1/N_1$');
ylabel('Remaining cycle ratio, $n_2/N_2$');

grid off;
box off;
daspect([1,1,1]);

%%
end_up(mfilename)