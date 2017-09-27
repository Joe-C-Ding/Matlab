start_tic = tic;
gcf;    % make sure figure1 is exsist
clf(1); ax = axes('parent', 1);
hold(ax, 'on');
grid(ax, 'on');

y = (-10:0.01:10)';
N = 1000;
nu = 3;

%% º∆À„ G(y)
fx = @(x)tpdf(x, nu);
Fy = tcdf(y, nu);
Py = integral(@(x)x.*fx(x), -inf, y(1)) + cumtrapz(y, y .* fx(y));

K = Py - y .* Fy;
Gy = K ./ (2*K + y - tstat(nu));

%% º∆À„ Gn(y)
xn = trnd(nu, N, 1);

[cx, x] = ecdf(xn);
x(1) = -1e5;
Fn = interp1(x, cx, y, 'previous', 'extrap');
Pn = zeros(size(y));
for i = 1:length(y)
    Pn(i) = sum(xn(xn < y(i))) / N;
end

K = Pn - y .* Fn;
Gny = K ./ (2*K + y - mean(xn));

%% ª≠Õº
plot(ax, y, Gy - Gny);

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));