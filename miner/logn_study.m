start_tic = tic;
clf;

s1 = 0.4;
s2 = 0.6;

X = prob.LognormalDistribution(0, s1);
Y = prob.LognormalDistribution(0, s2);
Z = prob.LognormalDistribution(0, max(s1, s2));

L = @(u, r, rs)Y.cdf(Y.icdf(r) + rs.*(X.icdf(r) - X.icdf(u)));
Lz = @(u, r, rs)Z.cdf(Z.icdf(r) + rs.*(Z.icdf(r) - Z.icdf(u)));
Lxy =  @(u, r, rs, X, Y)Y.cdf(Y.icdf(r) + rs.*(X.icdf(r) - X.icdf(u)));

S = @(r, rs)integral(@(u)L(u, r, rs), 0, 1);
Sz = @(r, rs)integral(@(u)Lz(u, r, rs), 0, 1);
Sxy = @(r, rs, X, Y)integral(@(u)Lxy(u, r, rs, X, Y), 0, 1);

Sv = @(r, rs)integral(@(u)L(u, r, rs), 0, 1, 'ArrayValued', 1);
Svz = @(r, rs)integral(@(u)Lz(u, r, rs), 0, 1, 'ArrayValued', 1);

if 0    % v
    rs = 1;
    r = 0.8;

    u = linspace(0, 1);
    v1 = L(u, r, rs);
    v2 = Lz(u, r, rs);

    plot(u, v1, 'r', u, v2);
    plot([r r], [0 1], 'k--', [0 1], [r r], 'k--');

elseif 0    % S1-S2 by rs
    rs = [0.1 0.2 0.5 0.7 1];
    r = linspace(0, 1);

    S1 = zeros(length(r), length(rs));
    S2 = zeros(length(r), length(rs));
    for i = 1:length(rs);
        S1(:,i) = Sv(r, rs(i));
        S2(:,i) = Svz(r, rs(i));
    end

    plot(r, S1-S2);
    xlabel('$R$');
    ylabel('$S_1-S_2$');
    
    s = strsplit(num2str(rs, '$\\eta=%.1f$\n'));
    legend(s);
    
elseif 0    % s1 by s2
    rs = 1;
    s2 = [0.1 0.2 0.3 0.5 0.7 1];
    s1 = [linspace(0.01, 1, 50) s2];
    s1 = unique(s1);    % this also sorts s1
    
    R = zeros(length(s1), length(s2));
    for i = 1:length(s1)
        X.sigma = s1(i);
        for j = 1:length(s2)
            if s1(i) > s2(j)
                R(i,j) = nan;
            else
                Y.sigma = s2(j);
                R(i,j) = fzero(@(r)Sxy(r, rs, X, Y)-r, [eps, 1-eps]);
            end
        end
    end
    
    plot(s1, R);
    xlabel('$\sigma_1$');
    ylabel('$R_p$');
    ylim([0.5 0.85]);
    
    s = strsplit(num2str(s2, '$\\sigma_2=%.1f$\n'));
    ht = text(s2+0.02, max(R), s, 'HorizontalAlignment', 'left');
    ht(end).HorizontalAlignment = 'right';
    ht(end).VerticalAlignment = 'base';
    ht(end).Position(1) = 0.98;
    
elseif 0    %** eta by s1
    rs = linspace(0.01, 1, 31);
    s1 = [0.1 0.2 0.3 0.5 0.7 1 1.2];
    s2 = 0.4;
    
    R = zeros(length(s1), length(rs));
    Y.sigma = s2;
    for i = 1:length(s1)
        X.sigma = s1(i);
        for j = 1:length(rs)
            R(i,j) = fzero(@(r)Sxy(r, rs(j), X, Y)-r, [eps, 1-eps]);
        end
    end
    
    R = R.';
    plot(rs, R);
    xlabel('$\eta$');
    ylabel('$R_p$');
    
    s = strsplit(num2str(s1, '$\\sigma_1=%.1f$\n'));
    idx = find(rs>=0.1, 1);
    ht = text(0.1*ones(length(s1),1), R(idx,:), s);
    set(ht, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left');
    
elseif 0    % s1 by eta, increase with s1
    rs = linspace(0.01, 1, 6);
    s1 = linspace(0.01, 1, 21);
    s2 = 0.5;
    
    R = zeros(length(s1), length(rs));
    Y.sigma = s2;
    for i = 1:length(s1)
        X.sigma = s1(i);
        for j = 1:length(rs)
            R(i,j) = fzero(@(r)Sxy(r, rs(j), X, Y)-r, [eps, 1-eps]);
        end
    end
    
    plot(s1, R);
    xlabel('$\sigma_1$');
    ylabel('$R_p$');
    
    s = strsplit(num2str(rs, '$\\eta=%.1f$\n'));
    ht = text(0.98*ones(length(rs),1), R(end,:), s);
    set(ht, 'HorizontalAlignment', 'right');
    
elseif 1    % max by eta, increase with eta
    rs = [0.1 0.3 0.5 1];
    s1 = linspace(0.01, 1, 30);
    
    R = zeros(length(s1), length(rs));
    for i = 1:length(s1)
        X.sigma = s1(i);
        Y.sigma = s1(i);
        for j = 1:length(rs)
            R(i,j) = fzero(@(r)Sxy(r, rs(j), X, Y)-r, [eps, 1-eps]);
        end
    end
    
    plot(s1, R);
    xlabel('$\sigma$');
    ylabel('$R_p$');
    
    s = strsplit(num2str(rs, '$\\eta=%.1f$\n'));
    for i = 1:length(s)
        ht = text(0.98, R(end,i), s(i));
        ht.HorizontalAlignment = 'right';
        ht.VerticalAlignment = 'top';
    end
end

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));