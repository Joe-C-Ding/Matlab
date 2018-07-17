start_tic = tic;
close all;

load type1_result.mat;
y_ca = y;
load type2_result.mat;
y_my = y;
clear x y bad;

g = {'Castillo', 'This Paper'};
lim = [500 700];

for i = 1:2
    figure;
    boxplot([y_ca(:,i), y_my(:,i)], g, 'Whisker',20);
    ylim([0 lim(i)]);
    
    h = gca;
    h.TickLabelInterpreter = 'latex';
end;

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));