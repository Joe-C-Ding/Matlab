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
if isvector(data)
    data = data(:);
end

if strcmpi(dist, 'logn') || strcmpi(dist, 'Lognormal')
    dist = 'Lognormal';
    para = zeros(size(data, 2), 2);
    distribution(size(data, 2), 1) = prob.LognormalDistribution;
    for i = 1:size(data, 2)
        para(i, :) = lognfit(data(:,i));
        distribution(i) = makedist(dist, para(i, 1), para(i, 2));
    end
% elseif
end

if isplot
    figure;
    probplot(dist, data);
end

end

