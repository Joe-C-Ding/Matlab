start_tic = tic;
close all

%%
load spectrum.mat;

s = stress;
n = numbers;
nm = sum(n(:,1));

m = 8;
a = (s/180).^m;
neq = zeros(1,4);
for i = 1:4
    neq(i) = a' * n(:,i);
end

R = @(N)1-normcdf(bsxfun(@plus, log(N), log(neq./nm)), 16.118, 1.050);
N = logspace(10, 15).';
rn = R(N);

lt = {"k-.", "k:", "k--", "k"};
for i = 1:4
    plot(N, rn(:,i), lt{i});
end
legend({"$A$", "$B$", "$C$", "$D$"}, 'location', 'sw');

h = gca;
h.XScale = 'log';
xticks(10.^(10:15));
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