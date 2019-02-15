start_tic = tic;
close all

load cmp_berretta.mat

h_line = zeros(4,1);
h_line(1) = plot(berretta(:,1), berretta(:,2), 'k');
lt = {'k--', 'k:', 'k-.'};
for i = 1:3
    h_line(i+1) = plot(gamma(:,1,i), gamma(:,2,i), lt{i});
end

h = legend({'Berretta', 'Gamma1', 'Gamma2', 'Gamma3'});
h.Location = 'northwest';

h = gca;
xlabel('$N$');
ylabel('$a/$mm');

h.XLim = [2e5 2e7];
h.XScale = 'log';
h.YLim = [5 60];
h.YTick = [5 10:10:60];
h.XTick = [1e6 1e7];

grid off

%%
fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));

figure(1);
if strncmpi(mfilename, 'plot_', 5)
    pname = mfilename;  % mfilename(6:end) wont work.
    print(pname(6:end), '-depsc');
else
    set(1, 'windowstyle', 'docked')
end