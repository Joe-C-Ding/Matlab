get_ready();
%%
load data
fix = true;

base = centered;
% base = measure;

if fix
    ind = base(:,2) == 0;
    base(ind,1) = 37;
end

x = base(:,1);
y = base(:,2);
plot(x, y, 'x');
daspect([1,1,1]);

r1 = 10;
r2 = 32;
r3 = 50;

[r,fval,exitflag,output] = fminsearch(@(r)loss(r, base), [r1,r2,r3])

[l, o, t, p, p_calc, y_calc] = loss(r, base);
plot(p_calc(:,1), p_calc(:,2));
plot(o(:,1), o(:,2), 'x');
plot(x, y_calc, 'd');

% if fix
%     r_fix = r;
%     save('data', 'r_fix', '-append');
% else
%     save('data', 'r', '-append');
% end

%%
end_up(mfilename);
