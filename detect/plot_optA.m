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

s = 70;
a0 = 2 * mm;
ac = 36 * mm;
C = C * (s*sqrt(pi))^m;
a2N = @(a) 2*(a(1)^(1-m/2) - a.^(1-m/2))/C/(m-2);

a = (a0^(1-m/2) - C*(m-2)*logspace(0,8)/2).^(2/(2-m));
a = sort([a linspace(a0, ac, 50)]);
a(a>ac) = [];
N = a2N(a);
plot(N, a);
plot(N(end), a(end), 'kx')

h = setlog('xy');
ylim([2 40] * mm)
xlim([1e7 1.2*max(N)]);
xlabel('$N$');
ylabel('$a/$mm');

h.YTick = [2 5 10 20 30] * mm;
h.YTickLabel = split(num2str(h.YTick*1000));

at = 5*mm;
Na = interp1(a, N, at);
plot(Na, at, 'ko');
plot([Na Na], [at, 23*mm], 'k:');
plot(N([end end]), [17*mm ac], 'k:');
dblarrow(gca, [Na N(end)], [20 20]*mm);

itvl = N(end)-Na;
itvl = km2rev(itvl, 1);
h = text(sqrt(Na*N(end)), 17*mm, sprintf('$%d\\times10^4 \\hbox{ km}$', floor(itvl)));
h.VerticalAlignment = 'top';
h.BackgroundColor = 'w';
h.FontSize = 9;

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));