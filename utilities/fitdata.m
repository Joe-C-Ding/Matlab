function [ distribution ] = fitdata( data, dist, isplot )
%FITDATA [ distribution ] = fitdata( data, dist, isplot )
%   

narginchk(1, 3);
if nargin < 3
    isplot = false;
end
if nargin < 2 || isempty(dist)
    dist = 'Lognormal';
end
if isvector(data)
    data = data(:);
end

if strcmpi(dist, 'logn')
    dist = 'Lognormal';
elseif strcmpi(dist, 'wbl')
    dist = 'Weibull';
end

distribution(size(data, 2), 1) = prob.LognormalDistribution;
for i = 1:size(data, 2)
    distribution(i) = fitdist(data(:,i), dist);
end

if isplot
    figure;
    probplot(dist, data);
end

end

