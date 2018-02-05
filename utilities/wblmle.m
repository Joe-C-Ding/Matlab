function [ shp, scl, loc ] = wblmle( x, verbose )
%WBLMLE [ shp, scl, loc ] = wblmle( x, verbose )

narginchk(1, 2);
if nargin < 2 || isempty(verbose)
    verbose = false;
end

if nargout < 3
    p = wblfit(x);
    
    scl = p(1);
    shp = p(2);
else
    p = gevfit(-x);
    
    shp = -1/p(1);
    scl = -p(2)/p(1);
    loc = p(2)/p(1) - p(3);
end

end
