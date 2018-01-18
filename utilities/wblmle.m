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
    return;
end

func = @(p)-logL(x, p(1), p(2), p(3));

p0 = min(x) - 0.2*std(x);
p0 = [p0 wblfit(x-p0)];

% opt = optimoptions('fsolve', 'Display', 'off');
if verbose
    [p,fval,exitflag,output] = fminsearch(func, p0);
    fval, exitflag, output	%#ok
else
    p = fminsearch(func, p0);
end

loc = p(1);
scl = p(2);
shp = p(3);

end

function l = logL( x, loc, scl, shp )
    z = (x-loc)/scl;
    if any(z <= 0)
        l = -inf;
    else
        l = -sum(z.^shp) + (shp-1)*sum(log(z)) + numel(x)*log(shp/scl);
    end
end