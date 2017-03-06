function r = Fsdt( s, d, t )
%FSDT Summary of this function goes here
%   Detailed explanation goes here

global Du a l b;
if isscalar(t)
    if t < s
        r = zeros(size(d));
    else
        r = gammainc(l*(Du-d), a*(t^b-s^b), 'upper');
    end
else
    if any(t < s)
        p = t < s;
        r(p) = 0;
    else
        p = zeros(size(t));
    end
    r(~p) = gammainc(l*(Du-d), a*(t(~p).^b-s^b), 'upper');
end

end

