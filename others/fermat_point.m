start_tic = tic;
close all

%%
sample = 1;
t = zeros(sample, 1);

N = 5;

for i = 1:sample
z = randn(N, 2);
z = z(:,1) + 1i * z(:,2);
zm = mean(z);


funcf = @(x) sum(abs(z - x(1) - 1i * x(2)));
% opt = optimset('fminsearch');
% opt.TolX = 1e-5;
fp = fminsearch(funcf, [real(zm), imag(zm)], opt);
fp = fp(1) + 1i * fp(2);


zp = z - fp;
zp = zp ./ abs(zp);
t(i) = abs(sum(zp));

% if t(i) > 1e-3
    figure;
    plot(z, 'ko', 'markersize', 5);
    plot(zm, 'ks');
    plot(fp, 'rx');
    plot(fp+zp, 'ro')

    axis equal;
    grid off;
% end
end

% figure;
% histogram(t, 100);
% ax = gca;
% ax.XAxis.Exponent = 0;



%%
fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));

figure(1);
if strncmpi(mfilename, 'plot_', 5)
    pname = mfilename;  % mfilename(6:end) wont work.
    print(pname(6:end), '-depsc');
else
    set(1, 'windowstyle', 'docked')
end