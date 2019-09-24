get_ready();

%%
r1 = linspace(eps, 3.1, 1000);
p1 = reallog(r1 ./ sin(r1));

p2 = linspace(p1(end), 3.5*pi, 1000);
r2 = pi - pi ./ (1 + exp(p2));

r = [r1, r2];
p = [p1, p2];

polarplot(p, r, 'k');
hold on;
polarplot(p+pi, r, 'k');

h = gca;
h.GridColor = 'none';
h.ThetaTick = [];
h.RTick = [];

%%
end_up(mfilename)