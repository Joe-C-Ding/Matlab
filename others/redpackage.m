start_tic = tic;
figure(1);
clf; ax = gca;

hold(ax, 'on');
grid(ax, 'on');

N = 30000;

X = 100 * ones(N, 1);
n = 10;

x = zeros(N, n);
r = rand(N, 10);
for i = 1:n
    M = 2 * X / (n - i + 1);
    x(:,i) = 0.01 + (M - 0.01) .* r(:, i);
    x(:,i) = round(x(:,i), 2);
    X = X - x(:,i);
end
x(:, end) = x(:, end) + X;

if any(sum(x, 2) - 100 > 0.001)
    disp('error');
else
    subplot(2,1,1)
    plot(mean(x), 'x-');
    ylim([9 11]);
    
    [m, i] = max(x, [], 2);
    [min(m), mean(m), max(m)]
    subplot(2,1,2)
    edgs = 0.5:1:11;
    I = histcounts(i, edgs);
    plot((edgs(2:end)+edgs(1:end-1))/2, I, 'ro-')
end

figure
i = 10;
histogram(x(:,i))

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));