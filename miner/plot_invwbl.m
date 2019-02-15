start_tic = tic;
close all;

X = invwbl(2);
Lur = @(u, r, rs, X)X.cdf((1+rs).*X.icdf(r) - rs.*X.icdf(u));
Lr = @(r, rs, X)integral(@(u)Lur(u, r, rs, X), 0, 1);
Lrv = @(r, rs, X)integral(@(u)Lur(u, r, rs, X), 0, 1, 'ArrayValued', 1);

%%
figure;
rs = linspace(0.01, 1, 31);
b = [1 2 3.5 10];
R = zeros(length(rs), length(b));

for j = 1:length(b)
    X.B = b(j);
    for i = 1:length(rs)
        R(i,j) = fzero(@(r)Lr(r, rs(i), X)-r, [eps, 1-eps]);
    end
end
plot(rs, R, 'k');
xlabel('$\eta$');
ylabel('$R_p$');

s = strsplit(num2str(b, '$\\beta=%.1f$\n'));
ht = text(0.98*ones(size(R(end,:))), R(end,:), s);
set(ht, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'top');

print('invwbl_Rb', '-depsc');

%%
% figure; X.B = 10; j = find(b==X.B, 1);
% r = linspace(0, 1, 31);
% hs = plot(r, Lrv(r, 1, X));
% plot([0 1], [0 1], 'k--');
% hp = plot(R(end,j), R(end,j), 'kx');
% xlabel('$R$');
% ylabel('$S$');
% ylim([0 1]);
% 
% hl = legend([hs, hp], {'$S(R)\bigm|{}_{\eta=1}$', '$S(R_p)=R_p$'});
% hl.Location = 'northwest';
% 
% ht = text(R(end)-.03, R(end), sprintf('$R_p=%.4f$', R(end)));
% ht.HorizontalAlignment = 'right';


%%
figure;
b = linspace(3.5, 30, 31);
R = zeros(size(b));

for i = 1:length(b);
    X.B = b(i);
    R(i) = fzero(@(r)Lr(r, 1, X)-r, [eps, 1-eps]);
end
hs = plot(b, R, 'k');
xlabel('$\beta$');
ylabel('$R_p$');

legend('$R_p(\beta)\bigm|{}_{\eta=1}$', 'location','nw');

print('invwbl_Rb_h1', '-depsc');

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));