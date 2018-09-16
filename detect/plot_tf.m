start_tic = tic;
% close all but one figure, or creat one if none is there.
h = groot; h = h.Children;
if length(h) > 1
    i = ([h.Number] ~= 1);
    close(h(i)); h = h(~i);
end
clf(h); grid off;

C = 1.82e-13;
m = 2.6465;
mm = 1e-3;

s = [70 65];
a0 = 2 * mm;
ac = 36 * mm;

ns = numel(s);
a = cell(ns,1);
N = cell(ns,1);
for i = 1:ns
    tC = C * (s(i)*sqrt(pi))^m;
    a2N = @(a) 2*(a(1)^(1-m/2) - a.^(1-m/2))/tC/(m-2);

    ta = (a0^(1-m/2) - tC*(m-2)*logspace(0,8)/2).^(2/(2-m));
    ta = sort([ta linspace(a0, ac, 50)]);
    ta(ta>ac) = [];
    
    a{i} = ta;
    N{i} = a2N(ta);
end

itvl = N{2}(end)/4.3;
T = itvl*[1 2 3 4 4.6];

line = ["k--", "k"];
hl = zeros(1,2);
for i = 1:ns
    hl(i) = plot(N{i}, a{i}, line(i));
    plot(N{i}(end), a{i}(end), 'kx');
    h = text(N{i}(end), a{i}(end)+1*mm, '$t_f$');
    h.VerticalAlignment = 'bottom';
    
    a1 = interp1(N{i}, a{i}, T);
    a1(a1 == ac) = nan;
    poda(a1);
    h = plot(T, a1, 'ko');
    h.MarkerSize = 6;
    
    h = text(T(3)+3e6, a1(3)+0.5*mm, '$a_3$');
    h.VerticalAlignment = 'top';
    h.HorizontalAlignment = 'left';
end

h = text(T(1)+4e6, a1(1)+1*mm, '$a_1$');
h.VerticalAlignment = 'bottom';
h.HorizontalAlignment = 'left';

h = text(T(2)+7e6, a1(2)+1.5*mm, '$a_2$');
h.VerticalAlignment = 'top';
h.HorizontalAlignment = 'left';

h = text(T(4)+4e6, a1(4), '$a_4$');
h.VerticalAlignment = 'top';
h.HorizontalAlignment = 'left';

ylim([2 36] * mm)
plotx(T, 'k:')

h = gca;
ylim([2 45] * mm)
xlim([1 1.1*T(end)]);
ploty(ac, 'k:');

h.YTick = [2*mm ac];
h.YTickLabel = {"$a_0$", "$a_u$"};
h.XTick = T;
h.XTickLabel = {"$t_1$", "$t_2$", "$t_3$", "$t_4$", "$t$"};

dblarrow(gca, T([1 2]), [20 20]*mm);
h = text(mean(T(1:2)), 20*mm, '$T$');
h.VerticalAlignment = 'bottom';

legend(hl, {'$t_f\in(t_3,t_4]$', '$t_f\in(t_4,t]$'}, 'Location','NW');

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));