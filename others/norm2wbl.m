function [ a, b ] = norm2wbl( mu, sigma, verbose )
%NORM2WBL [ a, b ] = norm2wbl( mu, sigma, verbose )
%   此处显示详细说明
narginchk(2, 3);
if nargin < 3
    verbose = false;
end

M = mu;
V = sigma * sigma;

func = @(x)wblstat_aux(x) - [M, V];
x0 = [mu+sigma, sigma];
if verbose
    [x,fval,exitflag,output] = fsolve(func, x0);
    fval, exitflag, output %#ok
else
    x = fsolve(func, x0);
end
a = x(1);
b = x(2);

end

function y = wblstat_aux(x)
    [y(1), y(2)] = wblstat(x(1), x(2));
end

