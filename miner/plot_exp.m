start_tic = tic;
close all;

X = prob.ExponentialDistribution();
Lur = @(u, r, rs)X.cdf((1+rs).*X.icdf(r) - rs.*X.icdf(u));
Lr = @(r, rs)integral(@(u)Lur(u, r, rs), 0, 1);
Lrv = @(r, rs)integral(@(u)Lur(u, r, rs), 0, 1, 'ArrayValued', 1);

%%
rs = linspace(eps, 1, 51);
R = zeros(1, length(rs));

for i = 1:length(rs)
    R(i) = fzero(@(r)Lr(r, rs(i))-r, [0+eps, 1-eps]);
end
plot(rs, R);
xlabel('$\eta$');
ylabel('$R_p$');

p = ismembertol(rs, 0.1:0.1:1, 1e-8);
[rs(p)', R(p)']
max(R)

%%
figure;
r = linspace(0, 1, 50);
hs = plot(r, Lrv(r, 1));
plot([0 1], [0 1], 'k--');
hp = plot(R(end), R(end), 'kx');
xlabel('$R$');
ylabel('$S$');
ylim([0 1]);

hl = legend([hs, hp], {'$S(R)\bigm|{}_{\eta=1}$', '$S(R_p)=R_p$'});
hl.Location = 'northwest';

ht = text(R(end)-.03, R(end), sprintf('$R_p=%.4f$', R(end)));
ht.HorizontalAlignment = 'right';


fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));