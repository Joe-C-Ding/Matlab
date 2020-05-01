function [l, o, t, p, p_calc, y_calc] = loss(r, obs)
%LOSS [l, o, t, p, p_calc, y_calc] = loss(r, obs)
o = nan(3, 2);
p = nan(1, 3);
t = nan(1, 3);
p_calc = nan;
y_calc = nan;

if any(r < 0)
    l = inf;
    return
end

r1 = r(1);
r2 = r(2);
r3 = r(3);

x = obs(:,1);
y = obs(:,2);

N = 1e4;

%% find O's.
o1 = [r1, y(1)];
o3 = [x(end), -r3];

oo = o3 - o1;
tb = atan2(oo(2), oo(1));

a = r2 - r1;
b = r3 - r2;
c = norm(oo);
if (a + b <= c)
    l = inf;
	return
end

tt = acos((a^2 + c^2 - b^2) /2/a/c);
[px, py] = pol2cart(tb+tt, r2-r1);
o2 = [px, py] + o1;

o = [o1; o2; o3];

%% find thetas
oo = o2 - o1;
t1 = -atan2(oo(2), oo(1));
p1 = o1(1) - r1 * cos(t1);

oo = o3 - o2;
t2 = -atan2(oo(2), oo(1)) - t1;
p2 = o2(1) - r2 * cos(t1+t2);

t3 = pi/2 - t1 - t2;
p3 = o3(1);

if p1 > p2 || p2 > p3
    l = inf;
    return
end

t = [t1, t2, t3];
p = [p1, p2, p3];

%% find loss
tt = linspace(pi, pi-t1, N).';
[tx, ty] = pol2cart(tt, r1);
p_calc = [tx, ty] + o1;

tt = linspace(pi-t1-0.01, pi-t1-t2, N).';
[tx, ty] = pol2cart(tt, r2);
p_calc = [p_calc; [tx, ty] + o2];

tt = linspace(pi-t1-t2-0.01, pi/2, N).';
[tx, ty] = pol2cart(tt, r3);
p_calc = [p_calc; [tx, ty] + o3];

y_calc = interp1(p_calc(:,1), p_calc(:,2), obs(:,1));
l = norm(y_calc - obs(:,2));
end

