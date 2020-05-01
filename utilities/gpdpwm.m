function [ shp, scl, w1 ] = gpdpwm( x, freq )
%WBLPWM [ shp, scl ] = gpdpwm( x )

if nargin < 2 || isempty(freq)
    freq = ones(size(x));
end

zerowgts = find(freq == 0);
if numel(zerowgts) > 0
    x(zerowgts) = [];
    freq(zerowgts) = [];
end

if numel(x) < 3
    error('gpdpwm: too few simples.')
end

[x, I] = sort(x(:), 'descend');
freq = reshape(freq(I), [], 1);

n = sum(freq);
w0 = sum(x .* freq) / n;

Fx = cumsum([0; freq]) / (n-1);
Fx = (Fx(1:end-1) + Fx(2:end)-1/(n-1)) / 2;
w1 = sum(x .* Fx .* freq/n);

denominator = w0 - 2 * w1;
% if denominator <= 0
%     error('gpdpwm: parameters can not be sovled!');
% end

shp = 2 - w0 / denominator;
scl = 2 *w0 * w1 / denominator;

end
