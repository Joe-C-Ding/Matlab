start_tic = tic;
clf

x = 1:50;
tx = x-1;

% y = resample(x, 10, 20);
% y = decimate(x, 2);
y = downsample(x, 2);
ty = (0:length(y)-1) ./ 0.5;

plot(tx, x, 'o', ty, y, 'x');

toc(start_tic);
