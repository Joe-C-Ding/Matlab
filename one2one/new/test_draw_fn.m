start_tic = tic;
figure(1);
clf; ax = gca;

s = [525 500 475 450 400];
Nf = 10 .^ [
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

pd = fitdata(Nf(:,1), 'logn');
fn = fn_extend(pd);

n = linspace(Nf(1,1)/10, Nf(end,1));
d = linspace(0.1, 1);

%% test pd
% figure
% plot(n, pd.pdf(n)); hold on;
% niqr = pd.icdf([1 2 3]/4);
% for i = 1:length(niqr)
%     plot([niqr(i), niqr(i)], [0 pd.pdf(niqr(i))], 'k');
% end
%%

[N, D] = meshgrid(n, d);
[Z, ZF, finfo] = fn(n,d);
h = surface(ax, N, D, Z); hold(ax, 'on');
h.LineStyle = 'none';
% ax.XLabel = 'life';
% ax.YLabel = 'degradation';

[zmax, zloc] = max(Z, [], 2);
plot3(ax, n(zloc), d, zmax, 'r');
c = 'yggg';
for i = 1:4
    idx = finfo(:,i);
    zz = Z.';
    [row, col] = size(zz);
    zz = zz(idx.' + row .* (0:col-1));

    plot3(ax, n(idx), d, zz, c(i));
end

%% test F(x) -> E(x)
% EN = trapz(n, 1-ZF, 2);
% E = finfo(:,1);
% e = EN - E;
% [mean(abs(e)), max(e), norm(e)]
% [d' e]

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));