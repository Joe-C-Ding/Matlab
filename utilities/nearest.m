function [ Y ] = nearest( x, y, X )
%NEAREST [ Y ] = nearest( x, y, X )
%   此处显示详细说明

xmin = min(x);
xmax = max(x);
Y = zeros(size(X), 'like', X);

p = (X > xmin & X < xmax);
Y(p) = interp1(x, y, X(p), 'nearest');

Y(X < xmin) = y(1);
Y(X > xmax) = y(end);

end

