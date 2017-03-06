start_tic = tic;
figure(1);
clf; ax = gca;

hold(ax, 'on');
grid(ax, 'on');

isnorm = true;
load norm_weibul.mat

n = 2:20:2000;
emax = zeros(size(n));
erms = zeros(size(n));

for i = 1:length(n)
    if isnorm
        [N, edges] = histcounts(xn, n(i), 'normalization', 'pdf');

        Fx = normcdf(edges, u, s);
        px = diff(Fx) ./ diff(edges);
        pdf = @(x)normpdf(x, u, s);
    else
        [N, edges] = histcounts(xw, n(i), 'normalization', 'pdf');

        Fx = wblcdf(edges-c, a, b);
        px = diff(Fx) ./ diff(edges);
        pdf = @(x)wblpdf(x-c, a, b);
    end
    
    emax(i) = max(abs(N - px));
    
    cedges = (edges(1:end-1) + edges(2:end)) / 2;
    S = integral(@(x)(pdf(x)-nearest(cedges,N,x)).^2, edges(1), edges(end));
    erms(i) = sqrt(S);
end

plot(ax, n, emax, 'r', 'linewidth', 2);
plot(ax, n, erms, 'b', 'linewidth', 2);

legend({'max', 'rms'''}, 'FontSize', 12)

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));