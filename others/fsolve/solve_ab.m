start_tic = tic;
format shortG;
format compact;

sigma_b = 280;

S = [150 200];
N = [430000, 150000];
% N = 10 .^ [5.6335, 5.1761];
% N = C / (S .^ m);

x = fsolve(@(x)helper_func(x, S, N, sigma_b), [0.5, 0.5])

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));