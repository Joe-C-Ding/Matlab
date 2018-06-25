start_tic = tic;
clf;

syms r s real;
assume(r <= 0.5 & r >= 0.1);
% r = sym(1/2);

z = r * exp(1i * s);
dz = diff(z, s);
f = rewrite(dz/(z-1), 'sincos');
f = simplify(f);
pretty(f)

a = 1i * r * (cos(s) + sin(s)*1i);
b = r * (cos(s)+ sin(s)*1i) - 1;
b_ = conj(b);

ab_ = a*b_/r
ab_ = expand(ab_)
bb_ = r/simplify(b*b_)

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));
