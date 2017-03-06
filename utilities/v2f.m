function [ f ] = v2f( v, inverse )
%V2F [ f ] = v2f( v, inverse )
%   �˴���ʾ��ϸ˵��

if nargin < 2
    inverse = false;
end
global diameter;
l = 3600 * pi * diameter / 1e6;

if inverse == true
    f = v * l;
else
    f = v / l;
end

end

