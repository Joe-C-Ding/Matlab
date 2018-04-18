start_tic = tic;
close all;

is_plot = cast([0 1], 'logical');

X = prob.LognormalDistribution();
Y = prob.LognormalDistribution();
Z = prob.LognormalDistribution();

L = @(u, r, rs)Y.cdf(Y.icdf(r) + rs.*(X.icdf(r) - X.icdf(u)));
Lz = @(u, r, rs)Z.cdf(Z.icdf(r) + rs.*(Z.icdf(r) - Z.icdf(u)));
Lxy =  @(u, r, rs, X, Y)Y.cdf(Y.icdf(r) + rs.*(X.icdf(r) - X.icdf(u)));

S = @(r, rs)integral(@(u)L(u, r, rs), 0, 1);
Sz = @(r, rs)integral(@(u)Lz(u, r, rs), 0, 1);
Sxy = @(r, rs, X, Y)integral(@(u)Lxy(u, r, rs, X, Y), 0, 1);

%%
if is_plot(1)
    figure;
    rs = linspace(0.01, 1, 31);
    s1 = [0.1 0.2 0.3 0.5 0.7 1 1.2];
    s2 = 0.5;
    
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
    set(ht, 'VerticalAlignment', 'middle', 'HorizontalAlignment', 'left');
%     set(ht, 'BackgroundColor', 'w');
    
    dim = [.651 .814 .22 .09];
    str = sprintf('$\\sigma_2=%.1f$', s2);
    ht = annotation('textbox',dim,'String',str,'FitBoxToText','on');
    ht.LineWidth = 1;
    ht.Interpreter = 'latex';
    ht.HorizontalAlignment = 'center';
    ht.VerticalAlignment = 'bottom';
end

%%
if is_plot(2)
    rs = 1;
    s1 = [linspace(0.01, 1, 31) 0.74];
    
    R = zeros(length(s1), 1);
    for i = 1:length(s1)
        X.sigma = s1(i);
        Y.sigma = s1(i);
        R(i) = fzero(@(r)Sxy(r, rs, X, Y)-r, [eps, 1-eps]);
    end
    
    plot(s1, R);
    xlabel('$\sigma$');
    ylabel('$R_p$');
    
    hl = legend('$R_p(\sigma)\bigm|{}_{\eta=1}$');
    hl.Location = 'northwest';
end

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));