start_tic = tic;
close all

load tunnel.mat;
gray = 0.5;

subplot(2,1,1);
plot(time, gps, 'color', gray*[1 1 1]);
plot(time, speed, 'color', 0*[1 1 1]);
h = legend({"GPS", "calc"}, 'location', 'n');
h.FontSize = 6;

xlim(time([1 end]));
% xlabel('time/s');
ylabel('km/h');
ylim([0 230]);

load stop.mat;

subplot(2,1,2);
plot(time, gps, 'color', gray*[1 1 1]);
plot(time, speed, 'color', 0*[1 1 1]);
h = legend({"GPS", "calc"}, 'location', 'sw');
h.FontSize = 6;

xlim(time([1 end]));
xlabel('time/s');
ylabel('km/h');

%%
fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));

figure(1);
if strncmpi(mfilename, 'plot_', 5)
    pname = mfilename;  % mfilename(6:end) wont work.
    print(pname(6:end), '-depsc');
else
    set(1, 'windowstyle', 'docked')
end