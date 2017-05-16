start_tic = tic;
close all;

listing = dir('rainflow\*.mat');
listing = {listing.name}';

Qedge = 0:0.5:120;
Yedge = -30:0.25:30;
[Y, Q] = meshgrid(Yedge, Qedge);

QYsum = zeros(length(Qedge), length(Yedge), 2);
for j = 1:length(listing)
    load(['rainflow\', listing{j}]);
    
    QYsum = QYsum + QY;
end
QYsum(QYsum < 1e-5) = 0;

X = {Yedge, Qedge};
s = {{'Y1', 'Y2'}, {'Q1', 'Q2'}};
for i = 1:2
    figure(i)
    ax = gca;
    hold(ax, 'on');
    grid(ax, 'on');
    
    Y = sum(QYsum, i);
    plot(ax, X{i}, Y(:,:,1), 'linewidth', 2);
    plot(ax, X{i}, Y(:,:,2), 'linewidth', 2);
    
    ax.YScale = 'log';
    ax.YLim = [1 1e5];
    
    legend(s{i}, 'FontSize', 12);
end

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));