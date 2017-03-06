start_tic = tic;
figure(1);
clf; ax = gca;

hold(ax, 'on');
grid(ax, 'on');

t = linspace(0, 4*pi);
y = sin(t);

plot(ax, t, y, 'linewidth', 2);
ax.YLim = [-1.5 1.5];
ax.XLim = t([1 end]);

ax.XTick = [];
ax.YTick = [-1.5, -1, 0, 1];
ax.YTickLabel = {'0', '$\sigma_{min}$', '$\sigma_m$', '$\sigma_{max}$'};
ax.TickLabelInterpreter = 'latex';
ax.FontSize = 14;

plot(ax, t([1 end]), [0 0], 'k-.');

p = ax.Position;

x1 = 1/8 * p(3) + p(1);
x2 = x1;
y1 = 1/2 * p(4) +  p(2);
y2 = 2.5/3 * p(4) + p(2);
h = annotation('doublearrow',[x1 x2],[y1 y2]);
h.Head1Style = 'vback3';
h.Head2Style = h.Head1Style;

width = 0.1;
hight = 0.08;
dim = [x1-width/2, (y1+y2)/2-hight/2, width, hight];
h = annotation('textbox',dim,'String','$\sigma_a$');
h.Interpreter = 'latex';
h.BackgroundColor = 'w';
h.LineStyle = 'none';
h.HorizontalAlignment = 'center';
h.VerticalAlignment = 'middle';
h.FontSize = 14;

x1 = 5/8 * p(3) + p(1);
x2 = x1;
y1 = 0.5/3 * p(4) +  p(2);
y2 = 2.5/3 * p(4) + p(2);
h = annotation('doublearrow',[x1 x2],[y1 y2]);
h.Head1Style = 'vback3';
h.Head2Style = h.Head1Style;

dim = [x1-width/2, (y1+y2)/2-hight/2, width, hight];
h = annotation('textbox',dim,'String','$\Delta\sigma$');
h.Interpreter = 'latex';
h.BackgroundColor = 'w';
h.LineStyle = 'none';
h.HorizontalAlignment = 'center';
h.VerticalAlignment = 'middle';
h.FontSize = 14;

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));