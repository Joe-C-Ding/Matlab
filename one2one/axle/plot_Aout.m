start_tic = tic;
% close all but one figure, or creat one if none is there.
h = get(groot, 'Children');
if length(h) > 1
    i = ([h.Number] == 1);
    close(h(~i)); h = h(i);
end
clf(h);

a = 410;

t = linspace(0, 2*pi);
d = rad2deg(t);
plot(d, a*cos(t), 'k--', d, a*cos(t+pi/2), 'k-.');
plot(d, a*ones(size(t)), 'k');
legend({"$A_1$","$A_2$","$A$"}, 'location', 'se')

xlabel('$\theta/^\circ$');
ylabel('$\mu\varepsilon$');

xlim([0 360]);
xticks(0:90:360);

ylim([-470 470]);
yticks(-600:200:600);

%%
fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));

figure(1);
if strncmpi(mfilename, 'plot_', 5)
    pname = mfilename;  % mfilename(6:end) wont work.
    print(pname(6:end), '-depsc');
else
    set(1, 'windowstyle', 'docked')
end