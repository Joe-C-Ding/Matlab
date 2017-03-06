start_tic = tic;
close all;
set(0,'DefaultFigureWindowStyle','docked');

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
    ylim([55 80]);
    xlabel(['Y', num2str(i), ' (kN)']);
    ylabel(['Q', num2str(i), ' (kN)']);
end

set(0,'DefaultFigureWindowStyle','normal');
fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));