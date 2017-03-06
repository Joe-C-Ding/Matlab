start_tic = tic;

fs = 200;
load orig/Channel_01_imcCronosSL_125767.mat
% A1 = resample(cast(val, 'double'), fs, 2000);
% A1 = cast(A1, 'single');
A1 = downsample(val, 10);
load orig/Channel_02_imcCronosSL_125767.mat
% A2 = resample(cast(val, 'double'), fs, 2000);
% A2 = cast(A2, 'single');
A2 = downsample(val, 10);

load orig/Channel_33_imcCronosSL_125775.mat
% speed = resample(cast(val, 'double'), fs, 1000);
% speed = cast(speed, 'single');
speed = downsample(val, 5);

clear val;
[A1, A2, speed] = test_truncate(A1, A2, speed);

t = taxle(A1, fs);
save('Aspeed.mat', 'A1', 'A2', 'speed', 't', 'fs')

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));
