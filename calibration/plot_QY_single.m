start_tic = tic;
close all

% i = 4;
% file = ['rainflow\weight\' list{i}];
% load(file);

Qedge = 0:0.5:120;
Yedge = -30:0.25:30;
[Y, Q] = meshgrid(Yedge, Qedge);

% QYsum = QY;
% QYsum(QYsum < 1e-5) = 0;
QYsum(:,:,1) = QY1;
QYsum(:,:,2) = QY2;

offset = [0, 4];
row = length(Qedge);
col = length(Yedge);
for i = 1:2
    o = offset(i);
    QYsum(:,:,i) = [zeros(row, o), QYsum(:, 1:end-o, i)];
end

for i = 1:2
    figure(i)
    ax = gca;
    hold(ax, 'on');
    grid(ax, 'on');
    
    [~,h] = contourf(Y, Q, QYsum(:,:,i));
%     h.LineWidth = 2;
%     h.ShowText = 'on';
    
    colormap('jet');
    colorbar;
    
    xlim([-10 10]);
    ylim([55 80]);
    xlabel(['Y', num2str(i), ' (kN)']);
    ylabel(['Q', num2str(i), ' (kN)']);
end

X = {Yedge, Qedge};
s = {{'Y1', 'Y2'}, {'Q1', 'Q2'}};
for i = 1:2
    figure(i+2)
    ax = gca;
    hold(ax, 'on');
    grid(ax, 'on');
    
    Y = sum(QYsum, i);
    plot(ax, X{i}, Y(:,:,1), 'linewidth', 2);
    plot(ax, X{i}, Y(:,:,2), 'linewidth', 2);
    
    Y1 = Y(:,:,1); Y2 = Y(:,:,2);
    prominence = 0.1;
    [~,locs1] = findpeaks(Y1, X{i}, 'MinPeakProminence', prominence);
    [~,locs2] = findpeaks(Y2, X{i}, 'MinPeakProminence', prominence);
    
    threshold = 0.0005;
    X1 = X{i}(Y1 >= threshold);
    X2 = X{i}(Y2 >= threshold);
    X1([1 end]) = nan;
    X2([1 end]) = nan;
    [max(X1), min(X1), locs1]
    [max(X2), min(X2), locs2]
    
%     ax.YScale = 'log';
%     ax.YLim = [1 1e5];
    
    legend(s{i}, 'FontSize', 12);
end

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));