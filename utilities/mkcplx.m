function Z = mkcplx(X, Y, fine)
%MKCPLX mkcplx(X, Y, fine=500) or mkcplx(R, is_radius=false, fine=500)
%   Detailed explanation goes here
narginchk(1,3)
if nargin == 1
    if isscalar(X)  % (R)
        [X, Y] = mkbyR(X, false, 500);
    elseif isvector(X)  %(X)
        [X, Y] = meshgrid(X, X);
    else
        error('mkcplx: X neither scalar nor vector!');
    end

else
    if nargin < 3 || isempty(fine)
        fine = 500;
    elseif ~isscalar(fine) || floor(fine) ~= fine
        error('mkcplx: fine must be a integer');
    end

    if isscalar(X) && isa(Y, 'logical')	% (R, is_radius)
        [X, Y] = mkbyR(X, Y, fine);
        
    elseif isvector(X) && isvector(Y)	%(X, Y)
        if length(X) == 2
            X = linspace(X(1), X(2), fine);
        end
        if length(Y) == 2
            Y = linspace(Y(1), Y(2), fine);
        end
        [X, Y] = meshgrid(X, Y);
        
    elseif ismatrix(X) && ismatrix(Y)
        [x, y] = size(X);
        if x ~= size(Y,1) || y ~= size(Y,2)
            error('mkcplx: X and Y must have same size!');
        end
    else
        error('mkcplx: bad input!');
    end
end

Z = X + 1i*Y;

end

function [X, Y] = mkbyR(R, is_radius, fine)
    [X, Y] = meshgrid(linspace(-R, R, fine));
    if is_radius
        p = (hypot(X, Y) > R);
        X(p) = nan;
        Y(p) = nan;
    end
end