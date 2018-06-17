start_tic = tic;
close all;

s = [0.95          0.9        0.825         0.75        0.675];
Nf = [
        0.257        1.129        5.598        67.34        11748
        0.217         0.68         5.56        50.09        11748
        0.206         0.54         4.82        48.42         3295
        0.203        0.509         4.11        36.35         1459
        0.143        0.457        3.847        27.94         1400
        0.123        0.451         3.59        26.26         1330
         0.12        0.356         3.33         24.9         1250
        0.109        0.342        2.903         20.3         1242
        0.105        0.311         2.59        18.62          896
        0.085        0.295         2.41        17.28          659
        0.083        0.257          2.4        16.19          486
        0.076        0.252        1.492        15.58          367
        0.074        0.226         1.46         12.6          340
        0.072        0.216        1.258         9.93          280
        0.037        0.201        1.246         6.71          103
];

dist = {'Normal', 'wbl'};
type = 2;
for i = 1:length(dist)
    [U,V,paras] = psn_curve(Nf, s, dist{i}, [1 1], 0, type, 1);
    paras
    paras.pd
    v = reshape(V.ns(Nf, s), [], 1);
    
    figure;
    subplot(2,2,1);
    normplot(v);

    subplot(2,2,2);
    ecdf(v);
    fplot(@(x)U.v(x), [min(v), max(v)]);

    subplot(2,2,3);
    f = [0.01 0.1 0.5 0.9 0.99];
    plot(Nf, ones(size(Nf,1),1)*s, 'x');
    
    n_plot = logspace(log10(min(Nf(:))), log10(max(Nf(:))));
    s_plot = zeros(length(n_plot), length(f));
    for i = 1:length(f)
        s_plot(:,i) = U.nf(n_plot, f(i));
    end
    
    plot(n_plot, s_plot);
    set(gca, 'xscale', 'log');
end

%%
fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));