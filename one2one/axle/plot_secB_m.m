start_tic = tic;
close all

%%
load spectrum.mat;

s = stress;
n = numbers(:,2);
nm = sum(numbers(:,2));

m = [8 5];
sa = 180;
Na = 1e7;
Tg = 1.4;

a = bsxfun(@power, s/sa, m);
neq = (a' * n)';

mu = m.*log(sa) + log(Na);
nu = m.*log(Tg)/2.5631;

R = @(N, i)1-normcdf(bsxfun(@plus, log(N), log(neq(i)./nm)), log(Na), nu(i));
N = logspace(7.5, 14).';
rn = zeros(length(N), length(m));
for i = 1:length(m)
    rn(:,i) = R(N, i);
end

n = [1e9 5e9 1e10 1e12];
rN = zeros(length(n), length(m));
for i = 1:2
        rN(:,i) = R(n, i);
end
rN

lt = {"k", "k-."};
for i = 1:2
    plot(N, rn(:,i), lt{i});
end
legend({"$m'=8$", "$m'=5$"}, 'location', 'sw');

h = gca;
h.XScale = 'log';
xlim(N([1 end]));
xticks(10.^(8:2:15));
xlabel('$N$');
ylabel('$R$');

grid off;

%%
fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));

figure(1);
if strncmpi(mfilename, 'plot_', 5)
    pname = mfilename;  % mfilename(6:end) wont work.
    print(pname(6:end), '-depsc');
else
    set(1, 'windowstyle', 'docked')
end