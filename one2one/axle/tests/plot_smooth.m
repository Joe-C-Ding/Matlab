start_tic = tic;
% close all but one figure, or creat one if none is there.
h = get(groot, 'Children');
if length(h) > 1
    i = ([h.Number] == 1);
    close(h(~i)); h = h(i);
end
clf(h);

load smooth.mat;

plot(time, gps, 'color', 0.5*[1 1 1]);
plot(time, speed, 'color', 0.2*[1 1 1]);
legend({"GPS", "calc"}, 'location', 'se');

xlim(time([1 end]));
xlabel('time/[s]');
ylabel('[km/h]');

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));