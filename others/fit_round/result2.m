get_ready();
%%
load data
x = centered(:,1);
y = centered(:,2);
plot(x, y, 'ks');
daspect([1,1,1]);

ind = centered(:,2) == 0;
centered(ind,1) = 37;
    
fprintf('precious: R1 = %.3f, R2 = %.3f, R3 = %.3f\n', r_fix(1), r_fix(2), r_fix(3))

r1 = 2.5;
r2 = 22;
r3 = 60;

[~, o, ~, ~, p_calc] = loss([r1 r2 r3], centered);
plot(p_calc(:,1), p_calc(:,2), 'k-');
plot(o(:,1), o(:,2), 'ko');

h = text(o(1,1)+1.5, o(1,2), sprintf('$(%.1f, %.1f)$', o(1,1), o(1,2)));
h.HorizontalAlignment = 'left';

h = text(o(2,1)+1.5, o(2,2), sprintf('$(%.1f, %.1f)$', o(2,1), o(2,2)));
h.HorizontalAlignment = 'left';

h = text(o(3,1)-1, o(3,2)+1, sprintf('$(%.1f, %.1f)$', o(3,1), o(3,2)));
h.HorizontalAlignment = 'center';
h.VerticalAlignment = 'bottom';
%%
end_up(mfilename);
