function [ dadn ] = odefun( a, n, dividend, divisor, c, m )
%ODEFUN [ dnda ] = odefun( n, a, dividend, divisor, c, m )
%   此处显示详细说明

du = dividend(a);
dl = divisor(a);
dadn = c * (du ./ dl) .^ m;

dadn(du <= 0) = 0;
dadn(dl <= 0) = realmax;

end

