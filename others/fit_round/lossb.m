function [l, p_calc, y_calc] = lossb(p, obs)
%LOSSB Summary of this function goes here
%   Detailed explanation goes here
p_calc = nan(1, 2);
y_calc = nan;

if numel(p) == 2
    p0 = obs(1,:);
    p1 = [0, p(1)];
    p2 = [p(2), 0];
    p3 = obs(end,:);
elseif numel(p) == 4
    p0 = [0, p(1)];
    p1 = [0, p(2)];
    p2 = [p(3), 0];
    p3 = [p(4), 0];
else
    error('not support')
end

if p1(2) < p0(2) || p2(1) > p3(1)
    l = inf;
    return
end

t = linspace(0, 1, 1e4).';
p_calc = (1-t).^3 .* p0 + 3*t.*(1-t).^2 .* p1 + 3*t.^2.*(1-t) .* p2 + t.^3 .* p3;
y_calc = interp1(p_calc(:,1), p_calc(:,2), obs(:,1));

l = norm(y_calc - obs(:,2));
end

