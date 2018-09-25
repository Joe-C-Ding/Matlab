function handle = cplxplot(X, Y, Z)
%CPLXPLOT cplxplot(X, Y, Z) or cplxplot(Z, W) or cplxplot(R, @fh, is_radius)
%   Detailed explanation goes here

narginchk(2, 3);
if isa(Y, 'function_handle') % (R, @f, is_radius=false)
    if nargin < 3
        is_radius = false;
    else
        is_radius = Z;
    end
    
    R = abs(X); f = Y; 
    if ~isscalar(R) || imag(R) ~= 0 || R <= 0
        error('cplxplot: R must be a positive number')
    end

    [X, Y] = meshgrid(linspace(-R, R, 500));
    [x, y] = size(X);
    if is_radius
        p = (hypot(X, Y) > R);
        X(p) = nan;
        Y(p) = nan;
    end
    Z = f(X + 1i*Y);

else % (X, Y, Z) or (Z, W)
    if nargin < 3
        Z = Y;
        Y = imag(X);
        X = real(X);
    end

    if ~ismatrix(X) || ~ismatrix(Y)
        error('cplxplot: X Y must be matrices');
    end
    [x, y] = size(X);

    if  x ~= size(Y,1) || y ~= size(Y,2)
        error('cplxplot: X, Y sizes miss match');
    end
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

