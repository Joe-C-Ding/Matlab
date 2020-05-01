get_ready();
%%
load data
base = centered;
% base = measure;

x = base(:,1);
y = base(:,2);
plot(x, y, 'x');
daspect([1,1,1]);

p0 = y(1);
p1 = -10;
p2 = 20;
p3 = x(end);

% [r,fval,exitflag,output] = fminsearch(@(r)lossb(r, base), [p1, p2])
[r,fval,exitflag,output] = fminsearch(@(r)lossb(r, base), [p0, p1, p2, p3])

[l, p_calc, y_calc] = lossb(r, base);
plot(p_calc(:,1), p_calc(:,2));
plot(x, y_calc, 'd');

if numel(r) == 4
    plot([0 0 r(3), r(4)], [r(1), r(2), 0 0], 'o');
    bezier4 = r;
else
    plot([0 0 r(2), p3], [p0, r(1), 0 0], 'o');
    bezier2 = r;
end

save('data', 'bezier4', 'bezier2', '-append');

%%
end_up(mfilename);
