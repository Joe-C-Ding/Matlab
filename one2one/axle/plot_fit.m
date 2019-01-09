start_tic = tic;
close all

%%
load spectrum
i = 4;

n = numbers(:,i);
s = stress;

n(n<10) = nan;
[~,peak] = max(n);
idx = zeros(size(n), 'like', true);
idx(1:peak) = true;
iu = ~isnan(n) & idx;
id = ~isnan(n) & ~idx;

logn = reallog(n);
plot(n, s, 'k');

pu = polyfit(s(iu), logn(iu), 2)
pd = polyfit(s(id), logn(id), 1)

nu = polyval(pu, s(iu));
nd = polyval(pd, s(id));
% plot(exp(nu), s(iu), 'r--');
% plot(exp(nd), s(id), 'b--');

grid off;

h = gca;
h.XScale = 'log';
xlim([10 1e6]);
xticks(10.^(1:6));
xlabel('$N$/cycle');
ylabel('$S$/MPa');

if i == 4
    ylim([20 70]);
end


%%
fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));

figure(1);
if strncmpi(mfilename, 'plot_', 5)
    sec = 'ABCDEFG';
    print(['fit' sec(i)], '-depsc');
else
    set(1, 'windowstyle', 'docked')
end