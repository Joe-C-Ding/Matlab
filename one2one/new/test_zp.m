start_tic = tic;
clf;

s = hypot(0.1, 0.1);
A = normcdf(4, 2, s)
B = normcdf(4, 6, s)
C = normcdf(4, 10, s)
p = 0.81*A + 0.18*B + 0.01*C

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));