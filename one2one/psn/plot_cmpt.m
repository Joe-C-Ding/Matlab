start_tic = tic;
close all;

if ~exist('U', 'var') || ~isstruct(U)
    s = [525 500 475 450 400];
    Nf = 10.^[
        4.8615	5.0237	5.2391	5.3522	5.7547
        5.0126	5.0846	5.2949	5.4595	5.8529
        5.1059	5.1427	5.3469	5.4929	5.9830
        5.1358	5.3079	5.3508	5.5013	5.9874
        5.1655	5.5103	5.4366	5.7822	6.0614
        5.3461	5.5403	5.6690	5.8874	6.2864
        5.5478	5.6652	5.8075	6.1497	6.2985
        5.6580	5.8491	5.8693	6.1679	6.4020
        5.6658	5.9033	5.9126	6.1715	6.4062
        5.7712	5.9253	5.9787	6.2305	6.4996
    ];

    [U, V, para] = psn_curve(Nf, s);
end

%%
sample = 10;
s = 500;
f = 0.8;
n = U.sf(s, f);

xs = s*ones(sample, 1);
N = U.randn(s, 10);
% [xs N]
plot(N, xs, 'kx', 'linewidth', 2);
h = text(sqrt(n*1e5), 500-10, '$\Pr(N|s_0)=0.8$');
h.VerticalAlignment = 'Top';

xn = n*ones(sample, 1);
S = U.rands(n, 10) + 30;
% [xn S]
plot(xn, S, 'kx', 'linewidth', 2);
h = text(n, max(S)+10, '$\Pr(S|n_0)=0.8$?');
h.VerticalAlignment = 'bottom';
h.HorizontalAlignment = 'left';

xn = logspace(log10(1e5), log10(2e6));
xs = U.nf(xn, f);
h = plot(xn, xs, 'k');
legend(h, sprintf('P--S--N curve ($P=%.1f$)', f));

h = gca;
xlim([1e5, 2e6]);
h.XScale = 'log';

h.XTick = {};
h.YTick = {};

xlabel('N');
ylabel('S');

% at the end
h = textarrow(gca, [n+3e5 n], [s+15, s], '$(n_0,s_0)$');
h.LineWidth = 1;

%%
fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));

figure(1);
if strncmpi(mfilename, 'plot_', 5)
    pname = mfilename;  % mfilename(6:end) wont work.
    print(pname(6:end), '-depsc');
else
    set(1, 'windowstyle', 'docked')
end