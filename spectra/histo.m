start_tic = tic;
figure(1);
clf; ax = gca;

hold(ax, 'on');
grid(ax, 'on');

load norm_weibul.mat;

n = 6;
isnorm = true;

if isnorm
    x = xn;
    pd = makedist('Normal', u, s);

    [N, edges] = histcounts(x, n, 'normalization', 'pdf');


    Fx = pd.cdf(edges);
    px = diff(Fx) ./ diff(edges);
    pdf = @pd.pdf;
else
    x = xw;
    pd = makedist('Weibull', a, b);
    
    [N, edges] = histcounts(x, n, 'normalization', 'pdf');
    
    Fx = pd.cdf(edges-c);
    px = diff(Fx) ./ diff(edges);
    pdf = @(x)pd.pdf(x-c);
end

ax.XTick = edges;
cedges = (edges(1:end-1) + edges(2:end)) / 2;

x = linspace(edges(1), edges(end), 1e3);
plot(ax, x, pdf(x), 'r--');
stairs(ax, edges, [px 0], 'b');
plot(ax, cedges, N, 'ko');

S = integral(@(x)(pdf(x)-nearest(cedges,N,x)).^2, edges(1), edges(end))

dim = [.15 .6 .3 .3];
str = {
    sprintf('max = %.2g', max(abs(N - px))),
    sprintf('rms = %.2g', sqrt( (edges(2)-edges(1)) * sum((N - px).^2) )),
    sprintf('rms''= %.2g', sqrt(S)),
};
annotation('textbox',dim,'String',str,'FitBoxToText','on',...
    'FontName', 'dialoginput');

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));