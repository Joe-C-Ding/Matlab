start_tic = tic;
% close all but one figure, or creat one if none is there.
h = groot; h = h.Children;
if length(h) > 1
    i = ([h.Number] ~= 1);
    close(h(i)); h = h(~i);
end
clf(h);

syms x a b;
a = 2;
f = a*x^2 + b;
dfdx = diff(f, x)

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));