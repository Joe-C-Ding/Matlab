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

    [U, V, para] = psn_curve(s, Nf);
end

spct = [
    200 2e5
    250 8e5
    300 2.5e5
    350 1e5
    400 5e4
    450 1e4
];

s = spct(:,1);
n = spct(:,2);
sumn = sum(n);

F = [0.1 0.3 0.4 0.5 0.7 0.9];
N = zeros(length(s), length(F));
for i = 1:length(F)
    N(:,i) = U.sf(s, F(i));
end

N;
d = bsxfun(@rdivide, n, N);
D = sum(d, 1);
Np = sumn ./ D;

sample = 1e5;
dmc = sn_rnd(s, n, para, sample);
Dmc = sum(dmc);
[fd, d] = ecdf(Dmc);
Dp = interp1(fd, d, 1-F);
[F; D; Dp]

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));