function [ a, b ] = ms2para( mu, sigma, pdstat, verbose )
%NORM2PD [ a, b ] = ms2para( mu, sigma, pdstat, verbose )
%   此处显示详细说明

narginchk(3, 4);
if ~isa(pdstat, 'function_handle')
    error('pdstat should be a function handle');
end
if nargin < 4 || isempty(verbose)
    verbose = false;
end

f0 = [mu, sigma*sigma];
func = @(x)state(x, pdstat) - f0;

fh = functions(pdstat);
switch fh.function
    case 'normstat'
        a = mu; b = sigma;
        return;
    case 'wblstat'
        x0 = [hypot(mu, sigma)/sqrt(0.95), 1];
    case 'lognstat'
        a = log(mu.^2 ./ hypot(sigma, mu));
        b = sqrt(log(1 + (sigma/mu).^2));
        return;
    otherwise
        error('not implement');
end

opt = optimoptions('fsolve', 'Display', 'off');
[para,fval,exitflag,output] = fsolve(func, x0, opt);

if verbose || exitflag <= 0
    para, fval, exitflag, output	%#ok
end

a = para(1);
b = para(2);

end

function y = state(x, f)
    [m, v] = f(x(1), x(2));
    y = [m v];
end
