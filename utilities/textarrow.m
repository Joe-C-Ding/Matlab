function h = textarrow(ax, x, y, str)
%TEXTBOX h = textarrow(ax, x, y, str)
%   x:	[x_start x_end]
%   y:	[y_start y_end]
%   str: latex_string

narginchk(4, 4);
[xp, yp] = abs2rel(ax, x, y);

h = annotation('textarrow', xp,yp, 'String',str);
h.Interpreter = 'latex';
h.LineWidth = 1;
h.HeadLength = 6;
h.HeadWidth = 6;

end

