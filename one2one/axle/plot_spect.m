start_tic = tic;
% close all but one figure, or creat one if none is there.
h = get(groot, 'Children');
if length(h) > 1
    i = ([h.Number] == 1);
    close(h(~i)); h = h(i);
end
clf(h);

load spectrum.mat

group = {[1 2], [6 7], [3 4 5]};
name = {"A", "B", "C", "D", "E", "F", "G"};
lt = {"k-", "k-.", "k--", "k:"};

for i = 1:length(group)
    figure;
    sp = numbers(:, group{i});
    spc = cumsum(sp, 'reverse');
    for j = 1:length(group{i})
        plot(spc(:,j), stress, lt{j});
    end
    legend(name{group{i}});

    set(gca, 'XScale', 'log');
    xlim([10 1e7]);
    xlabel('cumulative numbers');
    xticks(10.^(1:7))
    ylim([10 80]);
    yticks(20:10:80);
    ylabel('stress/MPa');
end

group = {[1 2], [3 5], 4};
for i = 1:length(group)
    figure;
    sp = numbers(:, group{i});
    for j = 1:length(group{i})
        plot(stress, sp(:,j), lt{j});
    end
    legend(name{group{i}});

    xlim([20 50]);
    xticks(20:5:50);
    ylabel('numbers');
    xlabel('stress/MPa');
end

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));