start_tic = tic;
clf;

m = 4;
C = 1e15;

cv = 0.1;
conf = 0.3;

sample = 50000;

pdstat = @wblstat;
pdname = 'weibull';

fs = @(s)C ./ (s.^m);
fn = @(N)(C ./ N).^(1/m);

hcycle = fn(1e4);
endure = fn(5e6);

s = [
    150 50000
    200 10000
    300 5000
    400 1000
    500 500
    550 100
];

k = length(s);
N = zeros(k, 1);

para = zeros(k, 2);
para(:,1) = fs(s(:,1));
para(:,2) = cv * para(:,1);

M = zeros(sample, 1);
for i = 1:k
    [a, b] = ms2para(para(i,1), para(i,2), pdstat);
    
    pd = makedist(pdname, a, b);
    M = M + s(i,2)./pd.random(sample, 1);
    
    if conf == 0.5
        N(i) = pd.mean();
    else
        N(i) = pd.icdf(conf);
    end
end

M0 = sum(s(:,2) ./ N);
fprintf('%.3f / %.3f(%.3f) / %.3f, %.3f\n', min(M), mean(M), M0, max(M), std(M));

histogram(M);
h = gca;
plot([M0, M0], h.YLim, 'r--');

[f,x] = ecdf(M);
x(1) = []; f(1) = [];
p = interp1(x, f, M0)

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));