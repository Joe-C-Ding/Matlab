function [ shp, scl, loc ] = wblpwm( x )
%WBLPWM [ shp, scl, loc ] = wblpwm( x )
% Reffrence:
%   Hosking, J. R. M., Wallis, J. R., and Wood, E. F. (1985).
%   Estimation of the generalized extreme-value distribution by the method
%   of probability-weighted moments. Technometrics, 27:251¨C261.

x = sort(x(:), 'descend');
n = numel(x);

j = 0:(n-1);
b = [mean(x), j*x/(n-1)/n, (j.*(j-1))*x /(n-1)/(n-2)/n];
c = (2*b(2)-b(1))/(3*b(3)-b(1)) - log(2)/log(3);


shp = 1/(7.8590*c + 2.9554*c*c);
scl = (b(1)-2*b(2)) / gamma(1+1/shp) / (1-2^(-1/shp));
loc = b(1) - scl*gamma(1+1/shp);

end
