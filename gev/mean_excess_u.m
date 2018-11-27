function [u, eu] = mean_excess_u(x, u)
%EU [u, eu] = mean_excess_u(x, u)
%   calc e(u) := E(x-u | x>u)
narginchk(1, 2);

if nargin < 2 || isempty(u)
    u = linspace(min(x), max(x));
end

if ~isvector(x)
    error('excess_u: x must be a vector');
end
x = x(:);

excess = bsxfun(@minus, x, u);
excess(excess<=0) = nan;
eu = nanmean(excess);

end

