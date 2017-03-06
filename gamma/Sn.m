function F = Sn( t, pond )
%SN F = Sn( t, pond )
%   Detailed explanation goes here

F_start = tic;
global Du;
a0 = 5;
as0 = eps;
F = zeros(numel(t), 2);

n = floor(t(end)/tt(1));
Sn = zeros(n, 2);

Sn(1,1) = Ft(tt(1));
Sn(1,2) = Sn(1,1);
Sn(2,1) = integral(@(a)(pond(a+a0).*ptx(tt(1),a).*Fsdt(tt(1),a,tt(2))), as0, Du);
Sn(2,2) = Sn(2,1);
for i = 3:n
    Sn(i,:) = [integral2(@(y, x)f1(y, x, i, tt(i), a0), 0, Du, 0, @(y)y) ...
        integral2(@(y, x)f2(y, x, i, tt(i), a0), 0, Du, 0, @(y)y)];
end
Sn = cumsum(Sn);

for i = 1:numel(t)
    if ~mod(i, 10)
        disp([i numel(t)])
    end
    
    n = floor(t(i)/tt(1));
    switch n
        case 0
            F(i, 1) = Ft(t(i));
            F(i, 2) = F(i,1);
        case 1
            F(i,1) = Sn(1,1) ...
                + integral(@(a)(pond(a+a0).*ptx(tt(1),a).*Fsdt(tt(1),a,t(i))), as0, Du);
            F(i,2) = F(i,1);
        otherwise
            F(i,:) = Sn(n,:) ...
                + [integral2(@(x, y)f1(x, y, n+1, t(i), a0), 0, Du, 0, @(y)y) ...
                integral2(@(x, y)f2(x, y, n+1, t(i), a0), 0, Du, 0, @(y)y)];
    end
end

toc(F_start);
end

%%
function f = f1 (y, x, n, t, a0)
    f = pond(x+a0).^(n-2) .* pstdx(tt(1), tt(n-1), y, x) ...
        .* pond(y+a0) .* ptx(tt(n-1), y) .* Fsdt(tt(n-1), y, t);
    
    f(f == inf) = realmax;
end

function f = f2 (y, x, n, t, a0)
    f = pond(x+a0).^(n-2) .* pstdx(tt(n-2), tt(n-1), y, x) ...
        .* pond(y+a0) .* ptx(tt(n-1), y) .* Fsdt(tt(n-1), y, t);
    
    f(f == inf) = realmax;
end
