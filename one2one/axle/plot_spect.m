get_ready(false);

load spectrum.mat

group = {[1 2 6 7], [3 4 5]};
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

    h = gca;
    h.XScale = 'log';
    h.XMinorGrid = 'off';
    h.YMinorGrid = 'off';
    
    xlim([10 1e7]);
    xlabel('cumulative numbers');
    xticks(10.^(1:7))
    ylim([10 80]);
    yticks(20:10:80);
    ylabel('stress/MPa');
    
    grid off;
    box off;
    h = findobj(groot, 'Type', 'legend');
    set(h, 'Box', 'off');
    
    print(strcat('sp', name{group{i}}), '-depsc');
    savefig(strcat('sp', name{group{i}}));
end

group = {[1 2 6 7], [3 5], 4};
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
    
    h = gca;
    h.XMinorGrid = 'off';
    h.YMinorGrid = 'off';
    
    
    print(strcat('ht', name{group{i}}), '-depsc');
end

end_up(mfilename, {});