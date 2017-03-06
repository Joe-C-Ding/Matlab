function r = pstdx( s,t,d,x )
%PSTDX Summary of this function goes here
%   Detailed explanation goes here

global a b;
 r = betapdf(x./d, a*s^b, a*(t^b - s^b))./d;
 r(r == inf) = realmax;
 
 if d == 0
     r(:) = 0;
     r(1) = realmax;
 end
 
end

