function [ Z ] = zp_xy( x, y, p, N )
%ZP_XY [ zp ] = zp_xy( x, y, p )
%   此处显示详细说明
narginchk(2,4);
if nargin < 4
    N = 10000;
end
if nargin < 3
    p = 0.1;
end

if ismethod(x, 'icdf')
    [f, z] = ecdf(x.random(N,1) + y.random(N,1));
    
    xp = x.icdf(p);
    yp = y.icdf(p);
else
    [f, z] = ecdf(x + y);

    [g, x] = ecdf(x); xp = interp1(g, x, p);
    [g, y] = ecdf(y); yp = interp1(g, y, p);
end
zp = interp1(f, z, p);

Z = [zp, xp, yp, zp-xp-yp];

end

