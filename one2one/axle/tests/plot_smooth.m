start_tic = tic;
% close all but one figure, or creat one if none is there.
h = get(groot, 'Children');
if length(h) > 1
    i = ([h.Number] == 1);
    close(h(~i)); h = h(i);
end
clf(h);

load smooth.mat;
gray = 0.5;

plot(time, gps, 'color', gray*[1 1 1]);
plot(time, speed, 'color', 0*[1 1 1]);
legend({"GPS", "calc"}, 'location', 'se');

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