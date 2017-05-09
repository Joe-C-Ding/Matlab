function [ m, c, s2n, n2s ] = sn_curve( s, n, is_log )
%SN_CURVE [ m, c, s2n, n2s ] = sn_curve( s, n, is_log )
%   此处显示详细说明
narginchk(2, 3);
if nargin < 3
    is_log = false;
end
if is_log
    logs = s;
    logn = n;
else
    logs = log(s(:));
    logn = log(n(:));
end

p = polyfit(logs, logn, 1);
m = -p(1);
c = exp(p(2));

s2n = @(s) c ./ (s .^ m);
n2s = @(n) (c./n) .^ (1/m);

end

