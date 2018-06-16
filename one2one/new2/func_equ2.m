start_tic = tic;
% clf;

syms x y real;
syms a(x) c(x) d(y) f(y) b(x) e(y);
lhs = (a(x)*y +b(x))^c(x);
rhs = (d(y)*x +e(y))^f(y);

l0 = subs(lhs, y, 0);
r0 = subs(rhs, y, 0);

dl = diff(log(lhs), y);
dr = diff(log(rhs), y);

dl0 = simplify(subs(dl, y, 0));
dr0 = simplify(subs(dr, y, 0));
pretty(dl0)
pretty(dr0)

ddl = diff(dl, y);
ddr = diff(dr, y);

ddl0 = simplify(subs(ddl, y, 0));
ddr0 = simplify(subs(ddr, y, 0));
pretty(ddl0)
pretty(ddr0)


fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));