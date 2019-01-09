start_tic = tic;
close all

%%
N = 5000;
X = normrnd(0, 1, N, 1);

bin = [8 16 32 64];
lt = {"k", "k-.", "k--", "k:"};
leg = {"$k=8$", "$k=16$", "$k=32$", "$k=64$"};
yt = -5:1:5;

for i = 1:length(bin)
    n = bin(i);
    [h, x] = histcounts(X, n);

    px = sort([x(2:end-1) x]);
    ph = zeros(1, 2*n);
    ph(1:2:2*n) = h;
    ph(2:2:2*n) = h;

    plot(ph, px, lt{i});
end
ylim([-5 5]);
xlim([0 2500]);
ylabel('$X$');
xlabel('$n$');
yticks(yt);
legend(leg);

figure;
for i = 1:length(bin)
    n = bin(i);
    [h, x] = histcounts(X, n);
    dx = mean(diff(x));

    h = cumsum(h, 'reverse');
    px = sort([x(2:end-1) x]);
    ph = zeros(1, 2*n);
    ph(1:2:2*n) = h;
    ph(2:2:2*n) = h;

    plot(ph, px-dx/2, lt{i});
end
ylim([-5 5]);
xlim([0 5200]);
ylabel('$X$');
xlabel('$n$');
yticks(yt);
legend(leg);

figure
x = linspace(-5, 5);
pt = normpdf(x);
plot(pt, x, 'color', 0.6*[1 1 1], 'linewidth', 5);
legh = zeros(1, length(bin));
for i = 1:length(bin)
    n = bin(i);
    [h, x] = histcounts(X, n);
    
    dx = mean(diff(x));
    h = h/dx/N;
    
    px = sort([x(2:end-1) x]);
    ph = zeros(1, 2*n);
    ph(1:2:2*n) = h;
    ph(2:2:2*n) = h;

    legh(i) = plot(ph, px, lt{i});
end
ylim([-5 5]);
xlim([0 0.6]);
ylabel('$X$');
xlabel('pdf');
yticks(yt);
legend(legh, leg);

%%
fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));

figure(2);
if strncmpi(mfilename, 'plot_', 5)
%     pname = mfilename;  % mfilename(6:end) wont work.
    print(1, 'histn', '-depsc');
    print(2, 'histc', '-depsc');
    print(3, 'histf', '-depsc');
else
    set(1, 'windowstyle', 'docked')
end