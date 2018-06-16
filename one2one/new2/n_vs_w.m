start_tic = tic;
close all;

s = [525 500 475 450 400];
Nf = 10.^[
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

n = reallog(Nf);
s = bsxfun(@times, s, ones(size(n, 1), 1));

curve = @(x, s)(x(1) + x(2) ./ (s-x(3)));

a = mean(n)';
b = s(1,:)';
x0 = [b ones(length(a),1) a]\(a.*b);
x0 = [b ones(length(a),1) a-x0(1)]\(a.*b);

opt = optimoptions('lsqcurvefit', 'Display', 'off', 'MaxFunctionEvaluations', 5000);
[x,resnorm,residual,exitflag,output] = lsqcurvefit(curve, x0, s, n, [], [], opt)

a = x(1);
b = x(3);

figure;
v = (n(:)-x(1)).*(s(:)-x(3));
normplot(v);

figure;
ecdf(v);
[mu, sgm] = normfit(v);
cdf = @(x)normcdf(x, mu, sgm);
fplot(cdf, [min(v), max(v)]);

[h, p] = kstest(v, [v cdf(v)])

[ shp, scl, loc ] = wblpwm(v);
cdf2 = @(x)wblcdf(v-loc, scl, shp);
[h, p] = kstest(v, [v cdf2(v)])

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));