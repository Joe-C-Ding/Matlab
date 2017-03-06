function h = textbox(ax, str, loc, xy, pad)
%TEXTBOX h = textbox(ax, str, loc, xy, pad)
%   此处显示详细说明

narginchk(2, 5);

pos = ax.Position;
if nargin < 3 || isempty(loc)
    loc = 'NW';
end
if nargin < 4 || isempty(xy);
    xy = pos(1:2) + pos(3:4)/2;
end
if nargin < 5 || (~isscalar(pad) || pad <= 0 || pad >= 1)
    pad = 0.03;
end

hor = 'center';
ver = 'middle';
switch char(upper(loc))
    case 'N'
        ver = 'cap';
        xy = pos(1:2) + [0.5*pos(3) (1-pad)*pos(4)];
    case 'NE'
        ver = 'cap';
        hor = 'right';
        xy = pos(1:2) + [(1-pad)*pos(3) (1-pad)*pos(4)];
    case 'E'
        hor = 'right';
        xy = pos(1:2) + [(1-pad)*pos(3) 0.5*pos(4)];
    case 'SE'
        hor = 'right';
        ver = 'bottom';
        xy = pos(1:2) + [(1-pad)*pos(3) pad*pos(4)];
    case 'S'
        ver = 'bottom';
        xy = pos(1:2) + [0.5*pos(3) pad*pos(4)];
    case 'SW'
        ver = 'bottom';
        hor = 'left';
        xy = pos(1:2) + [pad*pos(3) pad*pos(4)];
    case 'W'
        hor = 'left';
        xy = pos(1:2) + [pad*pos(3) 0.5*pos(4)];
    case 'NW'
        hor = 'left';
        ver = 'cap';
        xy = pos(1:2) + [pad*pos(3) (1-pad)*pos(4)];
    case {'C', 'CENTER'}
        % do nothing.
end

dim = [xy-0.001 0.001 0.001];
h = annotation('textbox',dim,'String',str,'FitBoxToText','on');
h.HorizontalAlignment = hor;
h.VerticalAlignment = ver;

end

