start_tic = tic;
figure(1);
clf; ax = gca;

hold(ax, 'on');
grid(ax, 'on');

load norm_weibul.mat;

isnorm = false;

if isnorm
    pdf1 = @(x)normpdf(x, u, s);
    
    [mu, sg] = normfit(xn)
    pdf2 = @(x)normpdf(x, mu, sg);
else
    pdf1 = @(x)wblpdf(x-c, a, b);
    
    para = wblfit(xw-c)
    [m, v] = wblstat(para(1), para(2));
    [m+c, sqrt(v)]
    pdf2 = @(x)wblpdf(x-c, para(1), para(2));
    
    ax.XLim = [20 120];
end

x = linspace(-20, 120, 1e3);
y1 = pdf1(x);
y2 = pdf2(x);

plot(ax, x, y1, 'r--');
plot(ax, x, y2, 'b');
    
dim = [.15 .6 .3 .3];
str = {
    sprintf('max = %.2g', max(abs(y1 - y2))),...
    sprintf('rms''= %.2g', sqrt( 140/1e3 * sum((y1 - y2).^2) )),...
};
annotation('textbox',dim,'String',str,'FitBoxToText','on',...
    'FontName', 'dialoginput');

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));