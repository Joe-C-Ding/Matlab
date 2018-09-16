function [r] = km2rev(km, inverse)
%KM2REV [r] = km2rev(km, inverse=false)
%   convert ten thousand kilometer to revolutions, or vise versa.
if nargin < 2
    inverse = false;
end

if ~exist('diameter', 'var')
    diameter = 860;
end
l = 1e10 / pi / diameter;

if inverse == true
    r = km / l;
else
    r = km * l;
end
end

