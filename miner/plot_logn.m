start_tic = tic;
close all;

is_plot = cast([1 0], 'logical');

X = prob.LognormalDistribution();
Lur = @(u, r, rs, X)X.cdf((1+rs).*X.icdf(r) - rs.*X.icdf(u));
Lr = @(r, rs, X)integral(@(u)Lur(u, r, rs, X), 0, 1);
Lrv = @(r, rs, X)integral(@(u)Lur(u, r, rs, X), 0, 1, 'ArrayValued', 1);

%%
if is_plot(1)
    figure;
    rs = linspace(eps, 1, 51);
    b = [0.1 0.3 0.5 0.7 1 1.5 2];
    R = zeros(length(rs), length(b));

    for j = 1:length(b)
        X.sigma = b(j);
        for i = 1:length(rs)
            R(i,j) = fzero(@(r)Lr(r, rs(i), X)-r, [eps, 1-eps]);
        end
    end
    plot(rs, R);
    xlabel('$\eta$');
    ylabel('$R_p$');
    
    s = strsplit(num2str(b, '$\\sigma=%.1f$\n'));
    for i = 1:length(s)
        ht = text(0.98, R(end,i), s(i));
        ht.HorizontalAlignment = 'right';
        ht.VerticalAlignment = 'bottom';
    end
end

%%
if is_plot(2)
    figure; X.sigma = 0.4;
    r = linspace(0, 1, 50);
    hs = plot(r, Lrv(r, 1, X));
    plot([0 1], [0 1], 'k--');

    Rp = R(end, find(b==X.sigma, 1));
    hp = plot(Rp, Rp, 'kx');
    xlabel('$R$');
    ylabel('$S$');
    ylim([0 1]);

    hl = legend([hs, hp], {'$S(R)$', '$S(R_p)=R_p$'});
    hl.Location = 'northwest';

    ht = text(Rp-.03, Rp, sprintf('$R_p=%.4f$', Rp));
    ht.HorizontalAlignment = 'right';
end

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));