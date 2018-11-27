start_tic = tic;
% close all but one figure, or creat one if none is there.
h = get(groot, 'Children');
if length(h) > 1
    i = ([h.Number] == 1);
    close(h(~i)); h = h(i);
end
clf(h);

load testdata.mat;

subplot(2,1,1);
plot(time, A1, 'k');

xlim(time([1 end]));
xt = 2500:2500:time(end);
xticks(xt);
xticklabels([]);
ylabel('$A_1/[\mu\varepsilon]$');

subplot(2,1,2);
plot(time, gps, 'k');

xlim(time([1 end]));
xticks(xt);
xlabel('time/[s]');
ylabel('speed/[km/h]');

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));