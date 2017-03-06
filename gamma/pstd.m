function r = pstd( s,t,d )
%PSTD Summary of this function goes here
%   Detailed explanation goes here

global a l b;
r = gampdf(d, a*(t.^b - s.^b), 1/l);

end

