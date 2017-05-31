start_tic = tic;
gcf;
clf(1); ax = axes('parent', 1);
hold(ax, 'on');
grid(ax, 'on');

x = data(:,1);
y1 = data(:,2);
y2 = data(:,3);

z1 = trapz(x, y1);
z2 = trapz(x, y2);
y1 = y1/z1;
y2 = y2/z2;

data(:,4) = y1;
data(:,5) = y2;

% plot(x, y1, x, y2);

e = 1e-4;
y1(y1 < e) = nan;
y2(y2 < e) = nan;
plot(x, y1, x, y2);

[~,x1] = findpeaks(y1, x, 'MinPeakProminence', 0.005);
[ max(x(~isnan(y1))) min(x(~isnan(y1))) x1' ]

[~,x2] = findpeaks(y2, x, 'MinPeakProminence', 0.005);
[ max(x(~isnan(y2))) min(x(~isnan(y2))) x2' ]


fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));