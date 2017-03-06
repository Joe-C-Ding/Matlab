function [ fD ] = fn2fd( fN, n, d )
%FN2FD [ fD ] = fn2fd( fN )
%   此处显示详细说明

if isa(fN, 'function_handle')
    if nargin == 1
        fD = @(n, d)funcD(n, d, fN);
    elseif nargin == 3
        fD = funcD(n, d, fN);
    end
elseif ismatrix(fN)
    narginchk(3, 3);
    fD = funcD_calc(n, d, fN);
end

end

function [dres, Dres, dinfo] = funcD(n, d, fN)
    [~, Fres, ~, n, d] = fN(n, d);
    
    [dres, Dres, dinfo] = funcD_calc(n, d, Fres);
end

function [dres, Dres, dinfo] = funcD_calc(n, d, Fres)
    Dres = 1 - Fres;
    dmax = max(d);
    
    dinfo = zeros(4, length(n));
    if mean(abs(diff(d))) > 0.05
        dres = nan(size(Dres));
        dinfo(1, :) = nan(size(dinfo(1, :)));
    else
        dres = [bsxfun(@rdivide,diff(Dres),diff(d)); nan(1, length(n))];
        dinfo(1,:) = trapz(d, Fres);
    end
    
    diqr = [-1 0.25 0.5 0.75];
    for i = 1:length(n)
        if dmax < dinfo(1,i)
            dinfo(1,i) = nan;
        else
            dinfo(1,i) = find(d >= dinfo(1,i), 1);
        end
        
        for j = 2:length(diqr)
            if max(Dres(:, i)) < diqr(j)
                dinfo(j, i) = nan;
            else
                dinfo(j, i) = find(Dres(:, i) >= diqr(j), 1);
            end
        end
    end
end
