function [ m, c, s2n, n2s ] = sn_curve( s, n, is_log )
%SN_CURVE [ m, c, s2n, n2s ] = sn_curve( s, n, is_log )
%   此处显示详细说明
narginchk(2, 3);
if nargin < 3
    is_log = [1, 1];
elseif isscalar(is_log)
    is_log = [is_log, 1];
end

if isvector(s)
    if size(n, 2) ~= length(s)
        error('sn_curve: size mismatch.');
    end
    s = reshape(s, 1, []) .* ones(size(n));
end

if is_log(1)
    logs = log(s(:));
else
    logs = s(:);
end

if is_log(2)
    logn = log(n(:));
else
    logn = n(:);
end

p = polyfit(logs, logn, 1);
m = -p(1);
c = exp(p(2));

s2n = @(s) c ./ (s .^ m);
n2s = @(n) (c./n) .^ (1/m);

end

