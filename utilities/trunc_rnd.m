function rnd = trunc_rnd( dist, a, b, len, is_plot )
%TRUNC_DIST rnd = trunc_rnd( dist, a, b, len )
%   此处显示详细说明
narginchk(4, 5);
if nargin < 5
    is_plot = false;
end

u = rand(len, 1);

Fb = dist.cdf(b);
Fa = dist.cdf(a);
rnd = dist.icdf((Fb - Fa) .* u + Fa);

if is_plot
    figure;
    histogram(rnd, 'Normalization', 'pdf');

    x = linspace(a, b);
    hold on;
    plot(x, dist.pdf(x)./(Fb-Fa), 'r');
end

end

