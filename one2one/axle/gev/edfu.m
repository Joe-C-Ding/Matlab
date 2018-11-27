function pd = edfu( cdf, u, isplot )
%EDFU pd = edfu( cdf, u, p, isplot )
%   x: sample, or func of cdf, or [x cdf]

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
    
    u = u0;
    pd = makedist('GeneralizedPareto', x(1), x(2), u);
    
elseif isvector(cdf)    % x is sample
    x = cdf(:);
    if nargin < 2 || isempty(u)
        u = prctile(x, 80);
    end
    
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


if isplot
    figure;
    plot(x, f, 'r-', x, pd.cdf(x), 'b:');
    legend('ecdf', 'Pareto', 'location', 'se');
    xlabel(sprintf('$x,\\quad (u=%.2f)$', u));
    ylabel('$F_u(x)$')
end


end

