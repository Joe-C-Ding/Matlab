start_tic = tic;
hold off;

Dc = 1;
a = 1;

s = [525 500 475 450 400];
Nf = 10 .^ [
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

Nm = mean(Nf, 1);
[fo, ~] = fit(log10(s)',log10(Nm)','poly1')
m = -fo.p1;
C = 10^fo.p2;

% loglog(Nm, s, 'o'); hold on;
% loglog(C./s.^m, s);

i = 1;
k = Dc * (s(i)^m / C) ^ a;

Pn = lognfit(Nf(:,i));
fn = makedist('lognormal', 'mu', Pn(1), 'sigma', Pn(2));

ntest = Pn(1);

fd = @(d)lognpdf(d, a*Pn(1)+log(k), a*Pn(2));
fd2 = @(d)fn.pdf((d/k).^(1/a)) ./ (d/k).^(1-1/a) / k/a;

x = linspace(0, 2);
% plot(x, fn.pdf(x), 'r'); hold on;
% plot(Nf(:,i), zeros(size(Nf(:,i))), 'o');
% set(gca, 'xscale', 'log');
% xlim([4e1 2e3]);
plot(x, fd(x), 'x'); hold on
plot(x, fd2(x));

mn = fn.mean;
sn = fn.std;
md = integral(@(d)d.*fd(d), 0, inf)
sd = integral(@(d)d.^2.*fd(d), 0, inf) - md^2
ngt = 1 - fn.cdf(mn)
dlt = integral(fd, 0, 1)

% subplot(1,2,1);
% ecdf(Nf(:,i));
% hold on;
% plot(x, fn.cdf(x));
% 
% subplot(1,2,2);
% plot(x, fn.pdf(x));
% save_axis = axis(); hold on;
% plot([mm mm], [0, 1],'r',  mm + [-ss -ss ss ss], [0, 1, 1, 0], 'b');
% axis(save_axis);
% 
% figure
% d = linspace(0, 1e6);
% plot(d, fd(d));

toc(start_tic);