start_tic = tic;
close all;

a = -20.7843;
b = -1.10607;

loc = 18.2305;
scl = 1.68844;
shp = 2.70123;


w = prob.WeibullDistribution(scl, shp);

sample = 500;

v = w.random(1, sample) + loc;
s = 0.6 + (0.9-0.6)*rand(1, sample);
Nf = exp(bsxfun(@rdivide, v, log(s)-b) + a);

dist = {'wbl', 'normal'};
is_log = [true, false];
type = 1;
for i = 1:length(dist)
    [U,V,paras] = psn_curve(Nf, s, dist{i}, is_log(i), 1, type);
    
    v = reshape(V.ns(Nf, s), [], 1);
    [h, p, ks, cv] = kstest(v, 'cdf', [v U.v(v)]);
    [h, p, ks, cv]
end

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));