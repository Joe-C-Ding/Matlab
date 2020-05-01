start_tic = tic;
% close all but one figure, or creat one if none is there.
h = get(groot, 'Children');
if length(h) > 1
    i = ([h.Number] == 1);
    close(h(~i)); h = h(i);
end
clf(h);

load testdata.mat;
fs = 8;

subplot(2,1,1);
plot(time, A1, 'k');

xlim(time([1 end]));
xt = 2500:2500:time(end);
xticks(xt);
xticklabels([]);
ylim([-220 220]);
ylabel('$A_1/\mu\varepsilon$');

h = gca;
h.FontSize = fs;
h.YLabel.FontSize = fs;

subplot(2,1,2);
plot(time, gps, 'k');

xlim(time([1 end]));
xticks(xt);
xlabel('time/s');
ylim([0 220]);
ylabel('speed/(km/h)');

h = gca;
h.FontSize = fs;
h.YLabel.FontSize = fs;
h.XLabel.FontSize = fs;

set(gcf,'Position', [1 15 15 6]);

%%
fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));

figure(1);
if strncmpi(mfilename, 'plot_', 5)
    pname = mfilename;  % mfilename(6:end) wont work.
    print(pname(6:end), '-depsc');
else
    set(1, 'windowstyle', 'docked')
end