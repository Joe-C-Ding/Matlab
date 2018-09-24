function handle = cplxplot(X, Y, Z)
%CPLXPLOT cplxplot(X, Y, Z) or cplxplot(Z, W)
%   Detailed explanation goes here

narginchk(2, 3);
% handle for input of (Z, W)
if nargin < 3
    Z = Y;
    Y = imag(X);
    X = real(X);
end

% X must be a 2D vector
if length(size(X)) ~= 2 || length(size(Y)) ~= 2
    error('cplxplot: bad input');
end
[x, y] = size(X);

% X, Y must have the same size
if  x ~= size(Y,1) || y ~= size(Y,2)
    error('cplxplot: X, Y size miss match');
end

modulus = abs(Z);

C = zeros(x, y, 3);
% calc HSV
C(:,:,1) = mod(angle(Z)/2/pi, 1); 
C(:,:,2) = 1;
C(:,:,3) = (1-0.01.^modulus) ./ max(1-0.01.^modulus(:));

handle = surf(X, Y, modulus, hsv2rgb(C));
handle.LineStyle = 'none';

end

