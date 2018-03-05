function [ L ] = L2( r, rs, X, varargin )
%L2 L2 = @(u, r, rs, X)X.cdf((1+sum(rs))*X.icdf(r) - rs*X.icdf(u)');
%   Detailed explanation goes here

if numel(rs) < length(varargin)
    error('L2: bad input!');
end
n = length(varargin);

s = rs(1) * X.icdf(varargin{1});
for i = 2:n
    s = s + rs(i) * X.icdf(varargin{i});
end

L = X.cdf((1+sum(rs(1:n)))*X.icdf(r) - s);

end

