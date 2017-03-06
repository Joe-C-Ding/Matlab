function [ distribution ] = fitdata( data, dist, isplot )
%FITDATA [ distribution ] = fitdata( data, dist, isplot )
%   此处显示详细说明

narginchk(1, 3);
if nargin < 3
    isplot = false;
end
if nargin < 2 || isempty(dist)
    dist = 'Lognormal';
end

if strcmpi(dist, 'logn') || strcmpi(dist, 'Lognormal')
    dist = 'Lognormal';
    para = lognfit(data);
    distribution = makedist(dist, para(1), para(2));
% elseif
end

if isplot
    figure;
    probplot(dist, data);
end

end

