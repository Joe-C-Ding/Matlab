get_ready();

%%
m = 5;

s0 = 336;

n1 = 1e7;
n2 = 2.5e6;

n2s = @(n, n0) s0 * (n0 ./ n) .^ (1/m);
s2n = @(s, n0) n0 * (s0 / s) .^ m;

n = logspace(5, 8);
s1 = n2s(n, n1);
s2 = n2s(n, n2);

plot(n, s1, 'k', n, s2, 'k--');
grid off;

h = gca;
h.XScale = 'log';
h.YScale = 'log';

s = n2s(1e7, n2);
plot(n1, s0, 'ko');
plot(n2, s0, 'ko');
plot(n1, s, 'kx');

txt = sprintf('$(1\\times 10^7, 250)$', s);
h = text(1e7-0.05e7, s-5, txt);
h.HorizontalAlignment = 'right';
h.VerticalAlignment = 'top';

txt = sprintf('$(2.5\\times10^6, %d)$', s0);
h = text(n2-0.01e7, s0-5, txt);
h.HorizontalAlignment = 'right';
h.VerticalAlignment = 'top';

txt = sprintf('$(1\\times10^7, %d)$', s0);
h = text(1e7+0.1e7, s0+5, txt);
h.HorizontalAlignment = 'left';
h.VerticalAlignment = 'bottom';

title(sprintf('$S$--$N$ curve ($m=%d$)', m))
xlabel('$N$ / Cycles');
ylabel('$S$ / MPa');

h = gcf;
pos = h.Position;
pos(1, 3:4) = [10, 10*3/4];
h.Position = pos;
%%
end_up(mfilename)

h.WindowStyle = 'normal';