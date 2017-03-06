start_tic = tic;
figure(1);
clf; ax = gca;

hold(ax, 'on');
grid(ax, 'on');

listing = dir('rainflow\*.mat');
listing = {listing.name}';

sumA = zeros(300, 2, 14);
for i = 1:length(listing)
    load(['rainflow\', listing{i}]);
    
    x = A(:,1,1) / 2;
    sumA = sumA + A;
end

s = {};
c = {'A1','A2','B1','B2','C1','C2','D1','D2',...
    'E1','E2','F1','F2','G1','G2'};
k = 5:10;
for i = 1:length(k)
    h = plot(ax, cumsum(flipud(sumA(:, 2, k(i)))), flipud(x));
    h.LineWidth = 2;
    
    ax.XScale = 'log';
    ax.XLim = [1e1 1e7];
    ax.YLim = [0 100];
    ax.XTick = logspace(1,7,7);
    
    s{i} = c{k(i)};
end
legend(s, 'FontSize', 12);

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));