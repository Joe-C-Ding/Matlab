function [ h ] = plotx( x, varargin )
%PLOTX [ h ] = plotx( x )
%   Detailed explanation goes here

x = x(:) * [1 1];
y = get(gca, 'YLim');

for i = 1:size(x, 1);
    plot(x(i,:), y, varargin{:});
end

end

