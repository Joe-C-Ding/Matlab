function h = dblarrow(ax, x, y)
%TEXTBOX h = h = dblarrow(ax, x, y)
%   x:	[x_start x_end]
%   y:	[y_start y_end]

narginchk(3, 3);

pos = ax.Position;
xb = pos(1); yb = pos(2); w = pos(3); h = pos(4);

xl = ax.XLim; yl = ax.YLim;
if strcmp(ax.XScale, 'log')
    xl = reallog(xl); x = reallog(x);
end
if strcmp(ax.YScale, 'log')
    yl = reallog(yl); y = reallog(y);
end

xp = xb + w * (x-xl(1))./(xl(2)-xl(1));
yp = yb + h * (y-yl(1))./(yl(2)-yl(1));

h = annotation('doublearrow', xp,yp);
h.LineWidth = 1;
h.Head1Length = 6;
h.Head1Width = 6;
h.Head2Length = 6;
h.Head2Width = 6;

end

