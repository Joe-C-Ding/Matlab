start_tic = tic;
% close all but one figure, or creat one if none is there.
h = get(groot, 'Children');
if length(h) > 1
    i = ([h.Number] == 1);
    close(h(~i)); h = h(i);
end
clf(h);

load data.mat
data = dadn_trans;

x = []; dk = []; dadn = [];
for i = 1:length(data)
    x = [x; data{i}(:,1)];
    dk = [dk; data{i}(:,2)];
    dadn = [dadn; data{i}(:,3)];
end
dk = reallog(dk);
dadn = reallog(dadn);
coef = polyfit(dk, dadn, 1);

C = exp(coef(2));
m = coef(1);
disp([C m])

s = 450;
a0 = [1 1.1] * mm;
ac = 5 * mm;
C = C * sa2k_simple(s,1)^m;
a2N = @(a) 2*(a(1)^(1-m/2) - a.^(1-m/2))/C/(m-2);

lspec = ["k", "k--"];
for i = 1:length(a0)
    a = (a0(i)^(1-m/2) - C*(m-2)*logspace(0,6)/2).^(2/(2-m));
    a = sort([a linspace(a0(i), ac, 50)]);
    a(a>ac) = [];
    N = a2N(a);
    plot(N, a, lspec(i));
end

n0 = 2.5e5;
s0 = 4e-3;
plotx(n0, 'k:');
ploty(s0, 'k:');

n = a2N([a0(1), s0]);
n = n(2);
dn = a2N([a0(2), s0]);
dn = dn(2);

s = (a0(1)^(1-m/2) - C*(m-2)*n0/2).^(2/(2-m));
ds = (a0(2)^(1-m/2) - C*(m-2)*n0/2).^(2/(2-m));

sp1 = 2.5e-3;
np1 = a2N([a0(1) sp1]);
np1 = np1(2);

sp2 = 3e-3;
np2 = a2N([a0(2) sp1]);
np2 = np2(2);

%%
h = gca;
grid off;
h.YLim = [a0(1) ac];

h.XTick = n0;
h.XTickLabel = {'$n_0$'};
h.YTick = s0;
h.YTickLabel = {'$d_0$'};

h = text(n0+0.2e5, s0, '$(n_0,d_0)$');
h.VerticalAlignment = 'bottom';
h.HorizontalAlignment = 'left';

h = text(n, s0, '$n$');
h.VerticalAlignment = 'top';
h.HorizontalAlignment = 'left';

h = text(dn, s0, '$\Delta n$');
h.VerticalAlignment = 'bottom';
h.HorizontalAlignment = 'right';

h = text(n0+0.4e5, s+0.1e-3, '$d$');
h.VerticalAlignment = 'top';
h.HorizontalAlignment = 'left';

h = text(n0-0.3e5, ds+0.1e-3, '$\Delta d$');
h.VerticalAlignment = 'base';
h.HorizontalAlignment = 'right';

h = text(np1, sp1, '$P$');
h.VerticalAlignment = 'top';
h.HorizontalAlignment = 'left';

h = text(np2+0.3e5, sp2-0.3e-3, '$P+\Delta P$');
h.VerticalAlignment = 'base';
h.HorizontalAlignment = 'right';

%%
fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));

figure(1);
if strncmpi(mfilename, 'plot_', 5)
    pname = mfilename;  % mfilename(6:end) wont work.
    print(pname(6:end), '-depsc');
else
    set(1, 'windowstyle', 'docked')
end