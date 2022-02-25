function [ m, c, s2n, n2s ] = sn_curve_m( s0, n0, m, need_plot )
%SN_CURVE_M [ m, c, s2n, n2s ] = sn_curve_m( s0, n0, m, need_plot )
%   assistant for S^m N = C plot, which has a known `m` and a known fix point (n0, s0).

narginchk(3, 4)
if nargin < 4
    need_plot = true;
end

if ~isscalar(s0) || ~isscalar(n0) || ~isscalar(m)
    error('sn_curve_m: only support for scalar.');
end

c = s0^m * n0;

s2n = @(s) c ./ (s .^ m);
n2s = @(n) (c./n) .^ (1/m);

if need_plot
    figure;

    n = logspace(5, 8);
    s = n2s(n);
    plot(n, s, 'k')

    plot(n0, s0, 'ko');

    [n_e, n_p] = fixpow(n0);
    txt = sprintf('$(%.1f\\times 10^{%d}, %.0f)$', n_e, n_p, s0);

    h_txt = text(n0-0.05e7, s0-5, txt);
    h_txt.HorizontalAlignment = 'right';
    h_txt.VerticalAlignment = 'top';

    h = gca;
    h.XScale = 'log';
    h.YScale = 'log';
    
    title(sprintf('$S$--$N$ curve ($m=%d$)', m))
    xlabel('$N$ / Cycles');
    ylabel('$S$ / MPa');
end

end

function [n, pow] = fixpow(n)
    pow = 0;
    while n >= 10
        n = n / 10;
        pow = pow + 1;
    end
end

