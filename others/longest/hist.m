start_tic = tic;
clf;

load result.mat

edges = 2:11;
N = histcounts(res(:,2), edges);

[edges(1:end-1)' N']

bar(edges(1:end-1), N);
xlim([1, 11]);
h = gca;
h.XTick = 1:10;
h.YTick = 0:500:4000;

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));