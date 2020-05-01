start_tic = tic;
close all

%% prepare data
s = [525 500 475 450 400];
Nf = 10.^([
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
]);
[U, V, paras] = psn_curve(Nf, s, 'Normal', [true, false]);

% test result
Nr = 10.^[0.63, 0.77, 0.84, 0.90, 1.09, 1.12, 1.16, 1.20, 1.45];
R = 1 - (0.1:0.1:0.9) - 0.04;
% R = 1 - normcdf([-1.28, -0.84, -0.52, -0.25, 0.00, 0.25, ...
%                 0.52, 0.84, 1.28], 0, 1);

%%
loads = [
    240 1e5
    350 8e4
    400 2.5e4
    500 1e4
    400 2.5e4
    350 8e4
    240 1e5
];

s1 = loads(1,1);
n_tot = sum(loads(:,2));

h = @(n, p, s) bsxfun(@rdivide, n, U.sf(s, p));
hinv = @(d, p, s) bsxfun(@times, d, U.sf(s, p));
eta = @(d, n, p, s) h(hinv(d, p, s) + n, p, s);

alpha = @(p, s) U.sf(s1, p) ./ U.sf(s, p);
coef = @(p) eqcoef(p, alpha, loads);

dc = 1;
t = linspace(0, 200, 500);

r = zeros(size(t));
for i = 1:length(t)
    try
        [f,fval,exitflag,output]  = fzero(@(p) eta(0, t(i)*n_tot*coef(p), p, s1)-dc, [eps, 1-eps]);
%         [f,fval,exitflag,output]  = fzero(@(p) eta(0, t(i)*coef(p), p, s1)-dc, [eps, 1-eps]);
        if exitflag > 0
            r(i) = 1 - f;
        else
            [f,fval,exitflag,output]
            error('%s: error occurs', mfilename);
        end
    catch ME
        d = eta(0, t(i)*n_tot*coef([eps, 1-eps]), [eps, 1-eps], s1);
        if (dc > nanmax(d))
            r(i) = 1;
        elseif (dc < nanmin(d))
            r(i) = 0;
        else
            d
            error('%s: error occurs', mfilename);
        end
    end
end
plot(t,r, 'k');

h = plot(Nr, R, 'kx');
legend(h, 'test result');
xlabel('$N$');
ylabel('$R$');

h = gca;
h.XScale = 'log';
grid off;

xt = 10.^(5:8);
xticks(xt / n_tot);
xlim([5e5 5e7] / n_tot);
xticklabels(strsplit(num2str(log10(xt), '$10^{%d}$\n')))

%%
fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));

figure(1);
if strncmpi(mfilename, 'plot_', 5)
    pname = mfilename;  % mfilename(6:end) wont work.
    print(pname(6:end), '-depsc');
else
    set(1, 'windowstyle', 'docked')
end