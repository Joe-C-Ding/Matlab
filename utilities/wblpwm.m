function [ shp, scl, loc ] = wblpwm( x )
%WBLPWM [ shp, scl, loc ] = wblpwm( x )
% Reference:
%   Hosking, J. R. M., Wallis, J. R., and Wood, E. F. (1985).
%   Estimation of the generalized extreme-value distribution by the method
%   of probability-weighted moments. Technometrics, 27:251¨C261.

x = sort(x(:), 'descend');

n = numel(x);
if n < 3
    error('wblpwm: too few simples.')
end

j = 0:(n-1);
b = [sum(x), j*x/(n-1), (j.*(j-1))*x /(n-1)/(n-2)] ./ n;

c = (3*b(3)-b(1))/(2*b(2)-b(1));
func = @(k)(1-3^(-k))./(1-2^(-k)) - c;
[x,~,exitflag] = fzero(func, 0.5);
if exitflag <= 0
    error('wblpwm: cannot solve parameters.');
end

shp = 1/x;
scl = (b(1)-2*b(2)) / (1-2^(-1/shp)); % for temporary use
loc = b(1) - scl;
scl = scl / gamma(1+1/shp);

end
