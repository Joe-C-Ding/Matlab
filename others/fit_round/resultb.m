get_ready();
%%
load data
x = centered(:,1);
y = centered(:,2);
plot(x, y, 'ks');
daspect([1,1,1]);

[~, p_calc, y_calc] = lossb(bezier2, centered);
plot(p_calc(:,1), p_calc(:,2), 'k-');

if 0
    plot([0 0 bezier2(2), x(end)], [y(1), bezier2(1), 0 0], 'kd');
else
    [~, p_calc, y_calc] = lossb(bezier4, centered);
    plot(p_calc(:,1), p_calc(:,2), 'k--');
    plot([0 bezier4(end)], [bezier4(1), 0], 'kx');
end

fprintf('endpoint: y = %.2f, x = %.2f\n', bezier4(1), bezier4(end));
%%
end_up(mfilename);
