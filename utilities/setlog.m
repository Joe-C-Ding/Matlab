function h = setlog(xyz)
%LOGLOG Summary of this function goes here
%   Detailed explanation goes here
if isempty(xyz)
    xyz = 'xy';
end
h = gca;

if ismember('x', xyz)
    h.XScale = 'log';
else
    h.XScale = 'line';
end

if ismember('y', xyz)
    h.YScale = 'log';
else
    h.YScale = 'line';
end

if ismember('z', xyz)
    h.ZScale = 'log';
else
    h.ZScale = 'line';
end

end

