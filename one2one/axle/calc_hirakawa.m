start_tic = tic;
close all

%%
load spectra.mat
i = 2;

n = numbers;
s = stress;

Tg = 1.4;
p = 0.5; 
U = getU(240, 1e7, Tg, 5, 5);

D = bsxfun(@rdivide, n, U.sf(s, p));
D = sum(D);
N = sum(n(:,1))./D;
N2 = km2rev(N, true);
[D' N' N2']


%%
fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));

figure(1);
if strncmpi(mfilename, 'plot_', 5)
    pname = mfilename;  % mfilename(6:end) wont work.
    print(pname(6:end), '-depsc');
else
    set(1, 'windowstyle', 'docked')
end