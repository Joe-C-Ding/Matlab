start_tic = tic;
close all;

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

logN = reallog(Nf);
logS = ones(size(Nf,1), 1) * s;

us = mean(logN)';
s = logS(1,:)';
x0 = [s us ones(length(us),1)]\(us.*s);
x0 = [s us-x0(1) ones(length(us),1)]\(us.*s)
x0(3) = [];

stat = @(x) (logN-x(1)).*(logS-x(2));
loss = get_loss(stat, 'normal');
[x,~,~,output] = fminsearch(loss, x0)

v = reshape(stat(x), [], 1);
[mu, sgm] = normfit(v)

figure;
subplot(2,2,1);
normplot(v);

subplot(2,2,2);
ecdf(v);
fplot(@(x)normcdf(x, mu, sgm), [min(v), max(v)]);

subplot(2,2,3);
f = [0.01 0.1 0.5 0.9 0.99];
plot(Nf, logS, 'x');

s_plot = linspace(min(s), max(s));
v = norminv(0.99, mu, sgm);
n_plot = exp(v./(s_plot-x(2)) + x(1));
% v = norminv(f, mu, sgm);
% s_plot = bsxfun(@rdivide, v, log(n_plot)-x(1)) + x(2);

plot(n_plot, s_plot);
% ylim([300 550]);
set(gca, 'xscale', 'log');


%%
fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));