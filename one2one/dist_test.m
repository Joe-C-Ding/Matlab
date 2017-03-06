start_tic = tic;
hold off;

hFit = @wblfit;
hPinv = @wblinv;
hSt = @wblstat;

s = [525 500 475 450 400];

Nf = [
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

i = 1;
alpha = 0.05;
X = Nf(:,i);
U = hFit(X, alpha);

x = linspace(4.5, 6)';
a = hPinv([0.55 0.5], U(1), U(2));
k = 1/(a(1) - a(2));

Y = k * (x - a(2));
f = ((1:length(X)) - 0.5) / length(X);
Y2 = k * (hPinv(f, U(1), U(2)) - a(2))';

plot(x, Y, 'r', X, Y2, 'o');
hold on

[fo,gof,output] = fit(X,Y2,'poly1')

disp('====== jbtest ======');
[h,p,jbstat,critval] = jbtest(X)
disp('====== lillietest ======');
[h,p,kstat,critval] = lillietest(X)


toc(start_tic);