function handle = cplxplot(W, Z)
%CPLXPLOT cplxplot(W, Z)
%   Detailed explanation goes here

X = real(W);
Y = imag(W);
modulus = abs(Z);

[x, y] = size(X);
C = zeros(x, y, 3);

% calc HSV
C(:,:,1) = mod(angle(Z)/2/pi, 1); 
C(:,:,2) = 1;
v = 1-0.01.^modulus;
C(:,:,3) = v ./ max(v(:));

handle = surf(X, Y, modulus, hsv2rgb(C));
handle.LineStyle = 'none';

end

