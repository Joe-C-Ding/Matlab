start_tic = tic;
gcf;    % make sure figure1 is exsist
clf(1); ax = axes('parent', 1);
hold(ax, 'on'); grid(ax, 'on');

ax.YScale = 'log';
ax.XScale = 'log';

s = [525 500 475 450 400];
Nf = exp([
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
]);

fns = fitdata(Nf, 'logn');
m = arrayfun(@(x)x.mean(), fns);
[m, c] = sn_curve(s, m);

fn = gen_fn(s, fns);

loads = [
    240 1e5
    350 8e4
    400 2.5e4
    500 1e4
    400 2.5e4
    350 8e4
    240 1e5
];
fns = fn(loads(:,1));
blocks = length(fns);
damage = zeros(length(fns), 1);
for i = 1:length(fns)
%     damage(i) = fns(i)(loads(i, 2));
end


fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));