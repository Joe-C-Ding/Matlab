start_tic = tic;
figure(1);
clf; ax = gca;

hold(ax, 'on');
grid(ax, 'on');

listing = dir('rainflow\*.mat');
listing = {listing.name}';

Qedge = 0:0.5:120;
Yedge = -30:0.25:30;
[Q, Y] = meshgrid(Qedge, Yedge);

QYsum = zeros(length(Qedge), length(Yedge));
for j = 1:length(listing)
    load(['rainflow\', listing{i}]);
    
    QYsum = QYsum + QY;
end

h = surface(ax, Y, Q, QY.');
h.EdgeColor = 'none';

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));