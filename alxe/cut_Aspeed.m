start_tic = tic;
clf

isplotorig = true;

load Aspeed.mat

fs = 200;
idx = [7900 9400];
idx(1) = find(t >= idx(1), 1);
idx(2) = find(t >= idx(2), 1);
idx = idx(1):idx(2);

A1 = A1(idx);
speed = speed(idx);
t = t(idx);

save('speed_200.mat', 'fs', 'A1', 't', 'speed');

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));