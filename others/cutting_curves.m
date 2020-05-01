get_ready();

%%
r1 = 1;
r2 = 1.1 * r1;

t = linspace(1.1*pi, 1.5*pi);
p1 = r1 * ones(size(t));
p2 = r2 * ones(size(t));

[x1, y1] = pol2cart(t, p1);
ax = [0 0];
%% method 1
subplot(1,2,1);
[x2, y2] = pol2cart(t, p2);
plot(x1, y1, 'k', x2, y2, 'k');
for i = 1:5:100
    plot([x1(i), x2(i)], [y1(i), y2(i)], 'k--');
end
ax(1) = gca;
daspect([1 1 1]);

%% method 2
subplot(1,2,2);
x2 = x1;
y2 = y1-0.1;
plot(x1, y1, 'k', x2, y2, 'k');
for i = 1:5:100
    plot([x1(i), x2(i)], [y1(i), y2(i)], 'k--');
end
ax(2) = gca;
daspect([1 1 1]);

set(ax, 'xlim', [-1.1, 0]);
set(ax, 'ylim', [-1.2, 0.1]);
set(ax, 'xtick', []);
set(ax, 'ytick', []);
%%
end_up(mfilename)