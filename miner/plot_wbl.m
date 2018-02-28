start_tic = tic;
close all;

X = prob.WeibullDistribution();
Lur = @(u, r, rs, X)X.cdf((1+rs).*X.icdf(r) - rs.*X.icdf(u));
Lr = @(r, rs, X)integral(@(u)Lur(u, r, rs, X), 0, 1);
Lrv = @(r, rs, X)integral(@(u)Lur(u, r, rs, X), 0, 1, 'ArrayValued', 1);

%%
rs = linspace(eps, 1, 51);
b = [0.3 0.5 1 2 3.5 10];
R = zeros(length(rs), length(b));

for j = 1:length(b)
    X.B = b(j);
    for i = 1:length(rs)
        R(i,j) = fzero(@(r)Lr(r, rs(i), X)-r, [eps, 1-eps]);
    end
end
plot(rs, R);
xlabel('$\eta$');
ylabel('$R_p$');

s = strsplit(num2str(b, '$\\beta=%.1f$\n'));
for i = 1:length(s)
    ht = text(0.98, R(end,i), s(i));
    ht.HorizontalAlignment = 'right';
    ht.VerticalAlignment = 'bottom';
end

%%
figure;
b = linspace(0.1, 10);
R = zeros(size(b));

for i = 1:length(b);
    X.B = b(i);
    R(i) = fzero(@(r)Lr(r, 1, X)-r, [eps, 1-eps]);
end
hs = plot(b, R);
xlabel('$\beta$');
ylabel('$R_p$');

legend('$R_p(\beta)\bigm|{}_{\eta=1}$')


fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));