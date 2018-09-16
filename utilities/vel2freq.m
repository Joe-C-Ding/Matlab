function [ f ] = vel2freq( v, inverse )
%V2F [ f ] = vel2freq( v, inverse=false )
%   convert velocity to frequence, or vise versa.

if nargin < 2
    inverse = false;
end

if ~exist('diameter', 'var')
    diameter = 860;
end
l = 3600 * pi * diameter / 1e6;

if inverse == true
    f = v * l;
else
    f = v / l;
end

end

