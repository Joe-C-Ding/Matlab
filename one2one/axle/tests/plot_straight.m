start_tic = tic;
% close all but one figure, or creat one if none is there.
h = get(groot, 'Children');
if length(h) > 1
    i = ([h.Number] == 1);
    close(h(~i)); h = h(i);
end
clf(h);

load testdata.mat;

t = 0.25;
I = 120000:(1200002+200*t);

A = hypot(A1, A2);
plot(time(I), A1(I), 'k--', ...
     time(I), A2(I), 'k-.', ...
     time(I), A(I), 'k');
legend({"$A_1$","$A_2$","$A$"}, 'location', 'se')

xlim([6000, 6000.25]);
xticks(6000:0.1:6000.25);
xlabel('time/[s]');
ylabel('$[\mu\varepsilon]$');
ylim([-200 200])

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));