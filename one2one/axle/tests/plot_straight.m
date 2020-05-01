start_tic = tic;
close all

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
xlabel('time/s');
ylabel('$\mu\varepsilon$');
ylim([-200 200])

%%
fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));

figure(1);
if strncmpi(mfilename, 'plot_', 5)
    pname = mfilename;  % mfilename(6:end) wont work.
    print(pname(6:end), '-depsc');
else
    set(1, 'windowstyle', 'docked')
end