function [pd, h] = edfu( cdf, u, isplot )
%EDFU pd = edfu( cdf, u, p, isplot )
%   cdf: sample, or func of cdf, or [x cdf]
%   return: GP distribution object.

narginchk(1, 3);
if nargin < 3 || isempty(isplot)
    isplot = false;
end

x0 = [-1, 10];
lb = [-inf, 0];
ub = [1, inf];
ops = optimoptions('lsqcurvefit','Display','off');
    
if isa(cdf, 'function_handle')
    if nargin < 2 || isempty(u)
        error('mean_excess_u: u must be given!');
    end

    u0 = u(1);
    Fu = (cdf(u)-cdf(u0))./(1-cdf(u0));
    x = lsqcurvefit(@(x,u)gpcdf(u, x(1),x(2), u0), ...
                    x0, u, Fu, lb, ub, ops);
    
    pd = makedist('GeneralizedPareto', x(1), x(2), u0);
    x = u;
    
elseif isvector(cdf)    % x is sample
    x = sort(cdf(:));
    if nargin < 2 || isempty(u)
        u = prctile(x, 80);
    end
    
    idx = find(x > u, 1);
    Fu = zeros(size(x));
    Fu(idx-1:end) = ecdf(x(x>u));
    pd = fitdist(x(x>u), 'GeneralizedPareto', 'Theta', u);

elseif ismatrix(cdf)    % [x cdf]
    x = cdf(:,1);
    F = cdf(:,2);

    if nargin < 2 || isempty(u)
        ui = find(F>=0.8, 1);
        if isempty(ui)
            error('edfu: can''t find p=0.9!');
        end
        u = x(ui);
    else
        ui = find(x>=u, 1);
    end

    F0 = F(ui);
    uu = x(ui:end);
    Fu = (F(ui:end)-F0) / (1-F0);
    
    x0 = [-1, 10];
    lb = [-inf, 0];
    ub = [1, inf];
    ops = optimoptions('lsqcurvefit','Display','off');
    x = lsqcurvefit(@(x,uu)gpcdf(uu, x(1),x(2),u), ...
                    x0, uu, Fu, lb, ub, ops);

    pd = makedist('GeneralizedPareto', x(1), x(2), u);

else
    error('edfu: bad cdf!')
end

h = [];
if isplot
    figure;
    h(1) = stairs(x, Fu, 'r-');
    h(2) = plot(x, pd.cdf(x), 'b:');
    legend('$F_u(x)$', '$G_{\xi,\beta}(x)$', 'location', 'se');
    xlabel(sprintf('$x,\\quad (u=%.2f)$', u));
    xlim([u x(end)]);
end


end

