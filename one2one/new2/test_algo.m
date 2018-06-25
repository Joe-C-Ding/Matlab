start_tic = tic;
close all;
clear psn_curve;

a = -20.7843;
b = -1.10607;

loc = 18.2305;
scl = 1.68844;
shp = 2.70123;

dist = 'wbl';
type = 2;

w = prob.WeibullDistribution(scl, shp);
s = [0.95  0.9 0.825 0.75 0.675];
ns = length(s);

sample = 15;
N = 1e4;

x = zeros(N, 5);
y = zeros(N, 2);
W = w.random(sample, N*ns) + loc;
parfor i = 1:N
    if mod(i, 100) == 0
        fprintf('%d ... (%f s)\n', i, toc(start_tic));
    end
    
    p = (i-1)*ns + (1:ns);
    Nf = exp(bsxfun(@rdivide, W(:,p), log(s)-b) + a);
    
    try
        [~,~,paras,output] = psn_curve(Nf, s, dist, [1 1], 0, type);
        
        x(i,:) = [paras.B paras.C ...
            paras.pd.loc paras.pd.scl paras.pd.shp];
        y(i,:) = [output.iterations output.funcCount];
    catch ME
        x(i,:) = nan;
        y(i,:) = nan;
    end
end

%% plot
t = [a b loc scl shp];
for i = 1:5
	figure;
    histogram(x(:,i));
    plotx(t(i), 'r--');
end

label = {'a   ', 'b   ', 'lambda', 'delta', 'beta',};
m = nanmean(x)-t;
s = nanstd(x);
for i = 1:5
    fprintf('%s\tmean: %.6g\tstd: %.6g\n', label{i}, m(i), s(i));
end

for i = 1:2
    figure;
    histogram(y(:,i));
end

label = {'iter', 'fcnt'};
f = [0.25 0.5 0.75];
for i = 1:2
    [ff, xx] = ecdf(y(:,i));
    iqry = [min(y(:,i)), ceil(interp1(ff, xx, f)), max(y(:,i))];
    fprintf('%s\t[%d, %d, %d, %d, %d]\n', label{i}, iqry);
end

bad

%%
% file = sprintf('type%d_result', type);
% save(file, 'x', 'y', 'bad');

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));