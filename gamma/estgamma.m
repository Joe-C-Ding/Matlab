function [ alpha, lambda ] = estgamma( aN, b )
%ESTGAMMA  [ alpha, lambda ] = estgamma( aN, b )
%   Detailed explanation goes here

dtb = []; da = [];
breakpoint = [find(aN == 0); size(aN, 1)+1];
for i = 1:numel(breakpoint)-1
    dtb = [dtb; diff(aN(breakpoint(i):breakpoint(i+1)-1, 1) .^ b)];
    da = [da; diff(aN(breakpoint(i):breakpoint(i+1)-1, 2))];
end
tnb = sum(dtb);
xn = sum(da);

au = 1;
al = au / 100;

while f(au, dtb, da, tnb, xn) < 0
    al = au; au = au * 100;
end

while f(al, dtb, da, tnb, xn) >= 0
    au = al; al = au/100;
end

step = 15;
while 1
    x = linspace(al, au, step);
    y = f(x, dtb, da, tnb, xn);
    
    idx = find(y==0, 1);
    if (~isempty(idx))
        au = x(idx); al = x(idx);
        break;
    else
        idx = find(y>0, 1);
        if (isempty(idx) || idx == 1)
            break;
        end
    end
    pau = au; pal = al;
    au = x(idx); al = x(idx-1);
    if (au == pau) && (al == pal)
        break;
    elseif numel(find(y==0)) >= 2
        au = al; al = x(find(y==0, 1));
        break;
    end
end

alpha = (au + al)/2;
lambda = alpha * tnb / xn;
end

function [ z ] = f(x, dtb, da, tnb, xn)
    z = dtb' * psi(dtb * x) - (dtb' * log(da)) - (tnb * log(x * tnb / xn));
end