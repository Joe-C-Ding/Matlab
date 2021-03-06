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

fns = fitdata(Nf, 'wbl');
t = fns(1);

figure;
x = t.icdf([0.01 0.99]);
x = linspace(x(1), x(2));
plot(x, t.pdf(x));

hold on;
N = t.random(1e3, 1);
m = t.mean();
D = m ./ N;
life = 1-t.cdf(m)
damg = sum(D < 1) ./ 1e3

% histogram(N, 'Normalization', 'pdf');
% h = gca;
% % h.XScale = 'log';
% 
% figure;
% histogram(D, 'Normalization', 'pdf');
% % xlim([0 20])
% h = gca;
% % h.XScale = 'log';

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));