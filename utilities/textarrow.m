function h = textarrow(ax, x, y, str)
%TEXTBOX h = textarrow(ax, x, y, str)
%   x:	[x_start x_end]
%   y:	[y_start y_end]
%   str: latex_string

narginchk(4, 4);

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

h = annotation('textarrow', xp,yp, 'String',str);
h.Interpreter = 'latex';
h.LineWidth = 1;
h.HeadLength = 6;
h.HeadWidth = 6;

end

