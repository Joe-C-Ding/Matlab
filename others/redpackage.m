start_tic = tic;
% close all but one figure, or creat one if none is there.
h = get(groot, 'Children');
if length(h) > 1
    i = ([h.Number] == 1);
    close(h(~i)); h = h(i);
end
clf(h); ax = gca;

hold(ax, 'on');
grid(ax, 'on');

N = 30000;

X = 100 * ones(N, 1);   % total amount
n = 10;                 % No. of people

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
    % mean of everone
    plot(mean(x), 'x-');
    ylim([9.9 10.1]);
    yticks(9.9:0.04:10.1)
    ylabel('mean');

    
    % max of everone
    m = max(x);
    yyaxis right;
    plot(m, 'x-');
    ylabel('max');
    xlim([1 10]);
    xticks([]);
    
    [m, i] = max(x, [], 2);
    fprintf('best draw: %.2f/%.2f/%.2f (min/mean/max)\n', ...
        min(m), mean(m), max(m));

    subplot(2,1,2)
    edgs = 0.5:1:11;
    I = histcounts(i, edgs);
    plot((edgs(2:end)+edgs(1:end-1))/2, I, 'ro-');
    ylabel('best times');
    xlim([1 10]);
    xticks(1:10);
end

figure % dist of them
edges = 0:1:40;
p = [1 5 10];
for i = p
    n = histcounts(x(:,i), edges, 'normalization', 'pdf');
    plot(edges(1:end-1), n);
end
legend(strsplit(num2str(p)));
xlabel('amount');
ylabel('pdf');

n = sum(x(:,10)>x(:,1));
fprintf('"10" > "1": %d (%.2f%%)\n', n, 100*n/N);


fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));