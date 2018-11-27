start_tic = tic;
% close all but one figure, or creat one if none is there.
h = get(groot, 'Children');
if length(h) > 1
    i = ([h.Number] == 1);
    close(h(~i)); h = h(i);
end
clf(h);

load start.mat;

subplot(2,1,1);
plot(time, A1, 'color', 0.1*[1 1 1]);

xlim(time([1 end]));
xticklabels([]);
ylabel('$A_1/[\mu\varepsilon]$');

subplot(2,1,2);
plot(time, gps, 'color', 0.5*[1 1 1]);
plot(time, speed, 'color', 0.2*[1 1 1]);
legend({"GPS", "calc"}, 'location', 'se');

xlim(time([1 end]));
xlabel('time/[s]');
ylabel('[km/h]');
ylim([0 30]);

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));