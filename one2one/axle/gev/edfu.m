function [ pd, ksstate ] = edfu( cdf, u, isplot )
%EDFU [ pd, ksstate ] = edfu( cdf, u, p, isplot )
%   x: sample, or func of cdf, or [x cdf]

narginchk(1, 3);
if nargin < 3 || isempty(isplot)
    isplot = false;
end

x0 = [-1, 10];
lb = [-inf, 0];
ub = [1, inf];
ops = optimoptions('lsqcurvefit','Display','off');
gpc = @(x,u)gpcdf(u, x(1),x(2),u0);
    
if isa(cdf, 'function_handle')
    if nargin < 2 || isempty(u)
        error('mean_excess_u: u must be given!');
    end

    Fu = @(u, x) (cdf(x+u)-cdf(u))./(1-cdf(u));

    x = lsqcurvefit(gpc, x0, uu, Fu, lb, ub, ops);
    pd = makedist('GeneralizedPareto', 'Theta', u);

elseif ismatrix(cdf)    % [x cdf]
    u = cdf(:,1);
    F = cdf(:,2);

    used = 10;
    u0 = u(end-used);
    F0 = F(end-used);
    uu = u(end-used:end);
    Fu = (F(end-used:end)-F0) / (1-F0);
    
    x0 = [-1, 10];
    lb = [-inf, 0];
    ub = [1, inf];
    ops = optimoptions('lsqcurvefit','Display','off');
    cdf = lsqcurvefit(@(x,u)gpcdf(u, x(1),x(2),u0), ...
                    x0, uu, Fu, lb, ub, ops);

    Fx = @(u)(1-F0)*gpcdf(u, cdf(1),cdf(2),u0) + F0;
    sm = integral(@(x)1-Fx(x), u(end), inf);

    Fc = 1-F;
    s = cumtrapz(cdf(:,1), Fc);
    eu = (s(end)-s+sm) ./ Fc;
    
elseif isvector(cdf)    % x is sample
    x = cdf(:);
    if nargin < 2 || isempty(u)
        u = prctile(x, 90);
    end
    
    pd = fitdist(x(x>u), 'GeneralizedPareto', 'Theta', u);
    [f, x] = ecdf(x(x>u));
    ksstate = max(abs(f - pd.cdf(x)));

else
    error('edfu: bad cdf!')
end

if isplot
    figure;
    plot(x, f, 'r-', x, pd.cdf(x), 'b:');
    legend('ecdf', 'Pareto', 'location', 'se');
    xlabel(sprintf('$x,\\quad (u=%.2f)$', u));
    ylabel('$F_u(x)$')
end


end

