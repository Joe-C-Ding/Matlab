function [ h ] = plotx( y, varargin )
%PLOTX [ h ] = plotx( y )
%   Detailed explanation goes here

y = y(:) * [1 1];
x = get(gca, 'XLim');

for i = 1:size(y, 1);
    plot(x, y(i,:), varargin{:});
end

end

