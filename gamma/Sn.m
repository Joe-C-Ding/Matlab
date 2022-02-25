function F = Sn( t, pond, show_procese )
%SN F = Sn( t, pond, show_procese )
%   Detailed explanation goes here
warn_save = warning;
warning('off');

narginchk(2, 3);
if nargin < 3
    show_procese = false;
end

F_start = tic;
global Du;
a0 = 2;
as0 = eps;
F = zeros(numel(t), 2);

n = floor(t(end)/tt(1));
Sn = zeros(n, 2);

if show_procese
    msg = sprintf('Calculating Sn [%%d / %d] ... %%3.2f s', 2*n);
    hbar = waitbar(0, sprintf(msg, 0, 0));
    sn_start = clock();
end

Sn(1,1) = Ft(tt(1));
Sn(1,2) = Sn(1,1);
Sn(2,1) = integral(@(a)(pond(a+a0).*ptx(tt(1),a).*Fsdt(tt(1),a,tt(2))), as0, Du);
Sn(2,2) = Sn(2,1);
if show_procese
    waitbar(2/n, hbar, sprintf(msg, 2, etime(clock(), sn_start)));
end

for i = 3:n
    Sn(i, 1) = integral2(@(y, x)f1(y, x, i, tt(i), a0), 0, Du, 0, @(y)y);
    if show_procese
        waitbar((i-0.5)/n, hbar, sprintf(msg, 2*i-1, etime(clock(), sn_start)));
    end
    Sn(i, 2) = integral2(@(y, x)f2(y, x, i, tt(i), a0), 0, Du, 0, @(y)y);
    if show_procese
        waitbar(i/n, hbar, sprintf(msg, 2*i, etime(clock(), sn_start)));
    end
end
Sn = cumsum(Sn);

if show_procese
    close(hbar);
end

m = numel(t);

if show_procese
    msg = sprintf('Calculating Fn [%%d / %d] ... %%3.2f s', m);
    hbar = waitbar(0, sprintf(msg, 0, etime(clock(), sn_start)));
end

for i = 1:m
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
    if show_procese
        waitbar(i/m, hbar, sprintf(msg, i, etime(clock(), sn_start)));
    end
end

if show_procese
    close(hbar);
end

toc(F_start);
warning(warn_save);
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
