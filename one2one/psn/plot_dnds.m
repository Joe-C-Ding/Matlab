start_tic = tic;
clf;

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

    [U, V, para] = psn_curve(s, Nf, 0);
end

%%
xn = logspace(5, log10(5e6));
p = 0.6;
dp = 0.1;

s1 = U.nf(xn, p);
s2 = U.nf(xn, p+dp);

n0 = 1.5e6;
s0 = 500;

n = U.sf(s0, p);
dn = U.sf(s0, p+dp);
s = U.nf(n0, p);
ds = U.nf(n0, p+dp);

np1 = 1.7e6/2;
sp1 = U.nf(np1, p);
np2 = 1.7e6/2;
sp2 = U.nf(np2, p+dp);


h = plot(xn, s1, 'k', xn, s2, 'k--');
plotx(1.5e6, 'k:');
ploty(500, 'k:');
ylim([380, 550]);
xlim([1, 2e6]);

h = gca;
h.XTick = [n0];
h.XTickLabel = {'$n_0$'};
xlabel('$N$');
h.YTick = [s0];
h.YTickLabel = {'$s_0$'};
ylabel('$S$');

%%
h = text(n0+0.05e6, s0+1, '$(n_0,s_0)$');
h.VerticalAlignment = 'bottom';
h.HorizontalAlignment = 'left';

h = text(n, s0, '$n$');
h.VerticalAlignment = 'top';
h.HorizontalAlignment = 'right';

h = text(dn, s0, '$\Delta n$');
h.VerticalAlignment = 'bottom';
h.HorizontalAlignment = 'left';

h = text(n0-0.05e6, s, '$s$');
h.VerticalAlignment = 'top';
h.HorizontalAlignment = 'right';

h = text(n0+0.05e6, ds+1, '$\Delta s$');
h.VerticalAlignment = 'base';
h.HorizontalAlignment = 'left';

h = text(np1-0.05e6, sp1, '$P$');
h.VerticalAlignment = 'top';
h.HorizontalAlignment = 'right';

h = text(np2, sp2, '$P+\Delta P$');
h.VerticalAlignment = 'bottom';
h.HorizontalAlignment = 'left';

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));