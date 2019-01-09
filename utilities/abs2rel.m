function [xp, yp] = abs2rel(ax, x, y)
%ABS2REL [x,y] = abs2rel(ax, x, y)
%   Detailed explanation goes here
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

end

