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
    R(i) = fzero(@(r)Lr(r, rs(i))-r, [0.1, 0.9]);
end
plot(rs(2:end), R(2:end), 'k');
xlabel('$\eta$');
ylabel('$R_p$');

grid off;
box off;

p = ismembertol(rs, 0.1:0.1:1, 1e-8);
[rs(p)', R(p)']
max(R)

print('exp_Rp', '-depsc');

%%
figure;
r = linspace(0, 1, 50);
hs = plot(r, Lrv(r, 1), 'k');
plot([0 1], [0 1], 'k--');
hp = plot(R(end), R(end), 'kx');
xlabel('$R$');
xticks(0:0.2:1)
ylabel('$\mathit{\Pi}$');
ylim([0 1]);
daspect([1 1 1]);

grid off;
box off;

hl = legend(hs, {'$\mathit{\Pi}(R)\bigm|{}_{\eta=1}$'});
hl.Location = 'southeast';
hl.EdgeColor = 'none';

ht = text(R(end)-.03, R(end), sprintf('$R_p=%.4f$', R(end)));
ht.HorizontalAlignment = 'right';

print('exp_SR', '-depsc');

%%
fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));

% figure(1);
% if strncmpi(mfilename, 'plot_', 5)
%     pname = mfilename;  % mfilename(6:end) wont work.
%     print(pname(6:end), '-depsc');
% else
%     set(1, 'windowstyle', 'docked')
% end