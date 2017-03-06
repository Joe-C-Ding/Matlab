function [ b, lambda ] = estgamma2( aN, a )
%ESTGAMMA2 [ b, lambda ] = estgamma2( aN, a )
%   Detailed explanation goes here

bl = 1;
bu = 10 * bl;

p = find(aN(2:end, 1)' == 0);
da = diff(aN(:, 2))'; da(p) = [];

while fa(bu, a, aN, p, da) < 0
    bl = bu; bu = bu * 10;
end

while fa(bl, a, aN, p, da) >= 0
    bu = bl; bl = bu/10;
end

step = 15;
while 1
    x = linspace(bl, bu, step);
    y = fa(x, a, aN, p, da);
    
    idx = find(y==0, 1);
    if (~isempty(idx))
        bu = x(idx); bl = x(idx);
        break;
    else
        idx = find(y>0, 1);
        if (isempty(idx) || idx == 1)
            break;
        end
    end;
    pbu = bu; pbl = bl;
    bu = x(idx); bl = x(idx-1);
    if (bu == pbu) && (bl == pbl)
        break;
    elseif numel(find(y==0)) >= 2
        bu = bl; bl = x(find(y==0, 1));
        break;
    end
end

b = (bu + bl)/2;
lambda = a * sum( aN([p size(aN, 1)], 1) .^b) / sum(da);

end

function [ z ] = fa(x, a, aN, p, da)
    [T, B] = meshgrid(aN(:,1), x);
    logT = log(T); logT(~isfinite(logT)) = 0;
    dtlogt = diff((T .^ B) .* logT, 1, 2);
    dtlogt(:, p) = [];
    dtb = diff(T .^ B, 1, 2); dtb(:,p) = [];
    psidtb = psi(a * dtb);
    
    tnlogt = sum(T(:,[p size(aN, 1)]).^B(:,[p size(aN, 1)]) .* logT(:,[p size(aN, 1)]), 2)';
    lb = a * sum(T(:,[p size(aN, 1)]).^B(:,[p size(aN, 1)]), 2)' ...
        / sum(da);
    
    z = zeros(size(x));
    for i = 1:numel(x)
        z(i) = dtlogt(i, :) * (psidtb(i, :) - log(da))' - tnlogt(i) * log(lb(i)); 
    end
end