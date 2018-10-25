start_tic = tic;
clf;

xtick = [10 20 30 50 100 200 400];
ytick = flip([50 10 1 0.1 1e-2 1e-3 1e-4 1e-5 1e-6 1e-7 1e-8 1e-9 1e-10]);
ytlab = cellstr(num2str(ytick', '%2.2g'));
ytick = logninv(ytick./100, 0, 1);

Tg = 1.3;

x1 = [200 133];
[mu, sg] = cdf2ms(x1(1), Tg);
x1 = [x1 logninv(1e-12, mu, sg)];
y1 = logncdf(x1, mu, sg)    %#ok
y1 = logninv(y1, 0, 1);

x2 = [250 144];
[mu, sg] = cdf2ms(x2(1), Tg);
x2 = [x2 logninv(1e-12, mu, sg)];
y2 = logncdf(x2, mu, sg)    %#ok
y2 = logninv(y2, 0, 1);

plot(x1([1 end]), y1([1 end]), 'b--');
plot(x2([1 end]), y2([1 end]), 'r--');

plot(x1(1:2), y1(1:2), 'bo');
text([x1(1)-50, x1(2)-33], y1(1:2), {'200', '133'})

plot(x2(1:2), y2(1:2), 'ro');
text([x2(1)+70, x2(2)+40], y2(1:2), {'250', '144'})

legend({'EA1N', 'EA4T'}, 'location', 'NW');

h = gca;
h.XScale = 'log';
h.YScale = 'log';
h.YLim = [ytick(1), ytick(end)];
h.XLim = [10 400];
h.XTick = xtick;
h.YTick = ytick;
h.YTickLabel = ytlab;
h.XMinorGrid = 'off';
h.YMinorGrid = 'off';

xlabel('stress [MPa]')
ylabel('failure [\%]')

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));