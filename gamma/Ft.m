function r = Ft( t )
%FT Summary of this function goes here
%   Detailed explanation goes here

global Du a l b;
r = gammainc(Du*l, a*t.^b, 'upper');

end

