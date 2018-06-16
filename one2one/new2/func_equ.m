start_tic = tic;
% clf;

syms x y real;
syms a1 a0 b1 b0 real;

b(x) = a0*y+b0;
a(x) = a1*y+b1;

f = a*x + b;
collect(f, [x,y])

% syms a b m s real;
a = -a0/a1; b = -b1/a1; m=(a0*b1)/a1^2-b0/a1; s=1/a1;
g = ((x-a)*(y-b)-m)/s;
collect(g, [x,y])

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));