function r = ptx( t,x )
%PTX Summary of this function goes here
%   Detailed explanation goes here

global a l b;
r = gampdf(x, a*t.^b, 1/l);

r(r == inf) = realmax;

end

