function [ r ] = km2r( tkm, inverse )
%KM2R [ r ] = km2r( tkm, inverse )
%   
if nargin < 2
    inverse = false;
end
global diameter;
l = pi * diameter / 1e10;

if inverse == true
    r = tkm * l;
else
    r = tkm / l;
end

end

