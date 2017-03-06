start_tic = tic;
close all;
% figure(1);
% clf; ax = gca;
% 
% hold(ax, 'on');
% grid(ax, 'on');

listing = dir('rainflow\*.mat');
listing = {listing.name}';

set(0,'DefaultFigureWindowStyle','docked');

xl = [20 60];
for j = 1:7
    s = {};

    figure(j); clf
    
    subplot(1,2,1);
    ax = gca;
    hold(ax, 'on');
    grid(ax, 'on');
    
    c = 2*j-1;
    for i = 1:length(listing)
        load(['rainflow\', listing{i}])
        x = A(:,1,c) / 2;
        y = A(:,2,c);

        plot(ax, x, y);
        xlim(xl);
        s{i} = listing{i}(6:end-8);
    end
    legend(s);
    
    subplot(1,2,2);
    ax = gca;
    hold(ax, 'on');
    grid(ax, 'on');
    
    c = 2*j;
    for i = 1:length(listing)
        load(['rainflow\', listing{i}])
        x = A(:,1,c) / 2;
        y = A(:,2,c);

        plot(ax, x, y);
        xlim(xl);
%         s{i} = listing{i}(6:end-8);
    end
    legend(s);
end

set(0,'DefaultFigureWindowStyle','normal');
fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));