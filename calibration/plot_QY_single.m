start_tic = tic;
close all

file = 'rainflow\empty\2014-07-27 08-32-45 (1).mat';
load(file);

Qedge = 0:0.5:120;
Yedge = -30:0.25:30;
[Y, Q] = meshgrid(Yedge, Qedge);

QYsum = QY;
QYsum(QYsum < 1e-5) = 0;

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
    
    xlim([-5 5]);
    ylim([40 60]);
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
    
    ax.YScale = 'log';
%     ax.YLim = [1 1e5];
    
    legend(s{i}, 'FontSize', 12);
end

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));