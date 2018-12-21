function eu = mean_excess_u(cdf, u)
%EU [u, eu] = mean_excess_u(cdf, u)
%   calc e(u) := E(x-u | x>u)
%   cdf: function of cdf, or [x cdf], or sample of x
narginchk(1, 2);

if isa(cdf, 'function_handle')
    if nargin < 2 || isempty(u)
        error('mean_excess_u: u must be given!');
    end

    Fu = @(u, x) (cdf(x+u)-cdf(u))./(1-cdf(u));
    eu = integral(@(x)1-Fu(u, x), 0, inf, 'arrayvalued', 1);

elseif isvector(cdf)    % x is sample
    x = cdf(:);
    if nargin < 2 || isempty(u)
        u = linspace(min(x), max(x));
    end

    eu = bsxfun(@minus, x, u);
    eu(eu<=0) = nan;
    eu = nanmean(eu);

elseif ismatrix(cdf)    % [x cdf]
    u = cdf(:,1);
    F = cdf(:,2);

    used = 10;
    while true
        u0 = u(end-used);
        F0 = F(end-used);
        
        if (1-F0) > 1e-7
            break;
        else
            used = used + 5;
        end
    end
    uu = u(end-used:end);
    Fu = (F(end-used:end)-F0) / (1-F0);
    
    x0 = [-1, 10];
    lb = [-inf, 0];
    ub = [1, inf];
    ops = optimoptions('lsqcurvefit','Display','off');
    x = lsqcurvefit(@(x,u)gpcdf(u, x(1),x(2),u0), ...
                    x0, uu, Fu, lb, ub, ops);

    Fx = @(u)(1-F0)*gpcdf(u, x(1),x(2),u0) + F0;
    sm = integral(@(x)1-Fx(x), u(end), inf);

    Fc = 1-F;
    s = cumtrapz(cdf(:,1), Fc);
    eu = (s(end)-s+sm) ./ Fc;
    
else
    error('mean_excess_u: bad x!')
end

end