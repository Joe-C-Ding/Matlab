function [ fN ] = fn_extend( pd, D )
%FN_EXTEND [ fN ] = fn_extend( pd, D )

narginchk(1, 2);
if nargin < 2
    D = 1;
end

fN = @(n,d)funcN(n, d, pd, D);
end

function d = checkd(d)
    if isvector(d)
        d = d(:);
    elseif ismatrix(d)
        d = d(:, 1);
    end
end

function n = checkn(n)
    if isvector(n)
        n = n(:).';
    elseif ismatrix(n)
        n = n(1, :);
    end
end

function [fres, Fres, finfo, n, d] = funcN(n, d, pd, D)
% n and d is passed out for internal use of fn2fd().
    n = checkn(n);
    d = checkd(d);
    nmax = max(n);
    
    fres = zeros(length(d), length(n));
    Fres = zeros(length(d), length(n));
    finfo = zeros(length(d), 4);
    
    m = d/D * pd.mean();
    s = d/D * pd.std();
    if strcmpi(pd.DistributionName, 'Lognormal')
        p1 = log( (m.^2) ./ sqrt(s.^2+m.^2) );
        p2 = sqrt(log( s.^2 ./ (m.^2) + 1 ));
%     else
    end
    
    for i = 1:length(d)
        pd2 = makedist(pd.DistributionName, p1(i), p2(i));
        fres(i,:) = pd2.pdf(n);
        Fres(i,:) = pd2.cdf(n);
        
        fiqr = [pd2.mean(), pd2.icdf([0.25, 0.5, 0.75])];
        for j = 1:length(fiqr)
            if nmax < fiqr(j)
                finfo(i,j) = nan;
            else
                finfo(i,j) = find(n >= fiqr(j), 1);
            end
        end
    end
end