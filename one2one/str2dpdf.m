function [ xd ] = str2dpdf( xs, Nf, Dc, a, dist)
%STR2DPDF [ xd ] = str2dpdf( xs, Nf, Dc, a, dist)
%   m & C is for S-N curve: NS^m = C;

need_draw = false;

if nargin < 5
    dist = 'logn';
end
if strcmpi(dist, 'logn')
    hFit = @lognfit;
    hPinv = @logninv;
    hSt = @lognstat;
elseif strcmpi(dist, 'norm')
    hFit = @normfit;
    hPinv = @norminv;
    hSt = @normstat;
elseif strcmpi(dist, 'wbl')
    hFit = @wblfit;
    hPinv = @wblinv;
    hSt = @wblstat;
end

s = Nf(1,:);
xl = size(Nf,2);
Nm = zeros(xl, 3);
for i = 1:size(Nm, 1)
    Pn = hFit(Nf(2:end,i));
    Nm(i,:) = hPinv([0.15866 0.5 0.84134], Pn(1), Pn(2));
end

m = zeros(3,1);
C = zeros(3,1);
for i = 1:3
    b = regress(log(Nm(:,i)), [ones(xl,1) log(s)']);
    m(i) = -b(2);
    C(i) = exp(b(1));
end

if need_draw
    figure
    loglog(Nf(2:end,:), (s'*ones(1,size(Nf,1)-1))', 'bo');
    hold on;
    y = linspace( min(s), max(s) );
    loglog(C(2)./y.^m(2), y, 'r', C(1)./y.^m(1), y, 'r--', C(3)./y.^m(3), y, 'r--');
    hold off;
end

k = Dc/C(2) * xs(:,1).^m(2);
r = log( C(3)/C(2) ./ xs(:,1).^(m(3)-m(2)) ) ./ log( C(2) ./ xs(:,1).^m(2) );

% D = k*n^a; sigma_D = a*r*ln(n);
xd = [k.*xs(:,2).^a a*r.*log(xs(:,2))];

end

