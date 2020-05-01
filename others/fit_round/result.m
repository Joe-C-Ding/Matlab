get_ready();
%%
load data
x = centered(:,1);
y = centered(:,2);
plot(x, y, 'ks');
daspect([1,1,1]);

fprintf('precious: r1 = %.3f, r2 = %.3f\n', r(1), r(2))
% [~, o, ~, ~, p_calc] = loss(r, centered);
% plot(p_calc(:,1), p_calc(:,2), 'b--');
% plot(o([1 2],1), o([1 2],2), 'bo');

[~, o, ~, ~, p_calc] = loss([9 32 50], centered);
plot(p_calc(:,1), p_calc(:,2), 'k-');
plot(o([1 2],1), o([1 2],2), 'ko');

h = text(o(1,1)+1.5, o(1,2), sprintf('$(%.0f, %.1f)$', o(1,1), o(1,2)));
h.HorizontalAlignment = 'left';

h = text(o(2,1)-1.5, o(2,2), sprintf('$(%.1f, %.0f)$', o(2,1), o(2,2)));
h.HorizontalAlignment = 'right';
%%
end_up(mfilename);
