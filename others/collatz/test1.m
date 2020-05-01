get_ready()

%%
x = linspace(0, 1).';
a = 0.4;
r = 0.1;
y = 1 - x .^ (r.^a);

plot(x, y);

knee = NaN(length(r), 2);
% opts = optimoptions(@lsqcurvefit,'display','off');
for i = 1:length(r)
    [s,~,exitflag] = fminsearch(@(knee) auxfunc(knee, x, y(:,i)), 0.35*[1, 1]);
    if exitflag > 0
        knee(i,:) = s;
        plot(s(1), s(2), 'kx');
        plot([0 s(1)], [1 s(2)], 'k--', [s(1) 1], [s(2) 0], 'k--');
    end
end
% 
% ind = 1:93;
% plot(knee(ind,1), knee(ind,2), 'x');

xlim([0 1]);
ylim([0 1]);
daspect([1,1,1]);
%%
end_up(mfilename)