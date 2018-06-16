function [ pd, ksstate ] = edfu( x, u, p, isplot )
%EDFU [ pd, ksstate ] = edfu( x, u, p, isplot )
%   Detailed explanation goes here

narginchk(1, 4);
if nargin < 4 || isempty(isplot)
    isplot = false;
end

if nargin < 3 || isempty(p) || ~isscalar(p) || p <= 0 || p >= 100
    given_p = false;
    p = 90;
else
    given_p = true;
    if p < 1, p = 100*p; end
end

if nargin < 2 || isempty(u) || given_p
    u = prctile(x, p);
end


pd = fitdist(x(x>u), 'GeneralizedPareto', 'Theta', u);

if nargout > 1 || isplot
    [f, x] = ecdf(x(x>u));
    ksstate = max(abs(f - pd.cdf(x)));
    
    if isplot
        figure;
        plot(x, f, 'r-', x, pd.cdf(x), 'b:');
        legend('ecdf', 'Pareto', 'location', 'se');
        xlabel(sprintf('$x-u,\\quad u=%.2f$', u));
        ylabel('$F_u(x)$')
    end
end

end

