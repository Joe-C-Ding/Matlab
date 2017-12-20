start_tic = tic;
clf;

syms x y z
[y, z] = solve([x+y+z==100, 3*x+2*y+z/3==100], [y, z])


fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));