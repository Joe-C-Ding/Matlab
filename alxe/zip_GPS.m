start_tic = tic;

N = 100;

load orig/Channel_33_imcCronosSL_125775.mat
speed = downsample(val, N);
load orig/Channel_35_imcCronosSL_125775.mat
east = downsample(val, N);
load orig/Channel_36_imcCronosSL_125775.mat
north = downsample(val, N);
load orig/Channel_37_imcCronosSL_125775.mat
hight = downsample(val, N);

clear val;
ts = taxle(speed, 1000/N).';

save('gps.mat', 'speed', 'east', 'north', 'hight', 'ts');

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));
