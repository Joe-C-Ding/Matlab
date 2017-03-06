start_tic = tic;
figure(1);
clf; ax = gca;

hold(ax, 'on');
grid(ax, 'on');

% load orig/one/Channel_01_imcCronosSL_125767.mat
% A1 = downsample(val, 10);
% load orig/one/Channel_02_imcCronosSL_125767.mat
% A2 = downsample(val, 10);
% 
% fs = 200;
% t = taxle(A1, fs);

subplot(2,1,1);
ax = gca; hold on; grid on;
A = sqrt(A1.^2 + A2.^2);
plot(ax, t, A1, 'r');
plot(ax, t, A2, 'b');
plot(ax, t, A, 'k');
xlim([90 120]);

subplot(2,1,2);
ax = gca; hold on; grid on;
[pxx, f] = periodogram([A1 A2], [], 512, fs);
plot(ax, f, pxx(:,1), 'r');
plot(ax, f, pxx(:,2), 'b');
xlim([0 40]);

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));