function n = sncurve( s, reverse, m, c, k )
%SNCURVE n = sncurve( s, m, c, k )
%   此处显示详细说明

narginchk(1,5);
if nargin < 2 || isempty(reverse)
    reverse = false;
end
if nargin < 3 || isempty(m)
    m = 3.0;
end
if nargin < 4 || isempty(c)
    c = 0.16e12;
end
if nargin < 5 || isempty(k)
    k = [5e6, 1e8];
end

m2 = 2*m - 1;
c1 = (c / k(1))^(m2 / m) * k(1);
c2 = (c1 / k(2))^(1 / m2);

n = zeros(size(s));
if ~reverse
    p = s >= c ^ (1/m);
    if any(p)
        n(p) = 1;
    end
    p = (s >= (c/k(1))^(1/m)) & (s < c^(1/m));
    if any(p)
        n(p) = c ./ (s(p).^m);
    end
    p = (s >= (c1/k(2))^(1/m2)) & (s < (c/k(1))^(1/m));
    if any(p)
        n(p) = c1 ./ (s(p).^m2);
    end
    p = s < (c1/k(2))^(1/m2);
    if any(p)
%         n(p) = Inf;
        n(p) = c1 ./ (s(p).^m2);
    end
else
    p = s <= k(1);
    if any(p)
        n(p) = (c ./ s(p)) .^ (1/m);
    end
    p = s > k(1) & s <= k(2);
    if any(p)
        n(p) = (c1 ./ s(p)) .^ (1/m2);
    end
    p = s > k(2);
    if any(p)
        n(p) = c2;
    end
end

end

