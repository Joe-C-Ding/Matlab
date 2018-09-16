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
C = C * (s*sqrt(pi))^m
a2N = @(a) 2*(a(1)^(1-m/2) - a.^(1-m/2))/C/(m-2);

a = (a0^(1-m/2) - C*(m-2)*logspace(0,8)/2).^(2/(2-m));
a = sort([a linspace(a0, ac, 50)]);
a(a>ac) = [];
itvl = km2rev(17);
T = itvl*[1 2 3 4];

N = a2N(a);
a1 = interp1(N, a, T);
poda(a1);

N = N - 0.6*(N(end)-3*itvl);
plot(N, a);
plot(N(end), a(end), 'kx')

N2 = N + 0.8*(itvl*4 - N(end));
plot(N2, a, '--');
plot(N2(end), a(end), 'kx')

a1 = interp1(N, a, T);
poda(a1);
h = plot(T, a1, 'ko');
h.MarkerSize = 6;

a2 = interp1(N2, a, T);
poda(a2);
h = plot(T, a2, 'ko');
h.MarkerSize = 6;

ylim([2 36] * mm)
plotx(T, 'k:')

h = gca;
ylim([2 40] * mm)
xlim([1 1.1*T(end)]);
xlabel('$N$');
ylabel('$a/$mm');
h.YTick = [2 10 20 30] * mm;
h.YTickLabel = split(num2str(h.YTick*1000));

dblarrow(gca, T([1 2]), [20 20]*mm);
h = text(mean(T(1:2)), 20*mm, '$T$');
h.VerticalAlignment = 'bottom';

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));