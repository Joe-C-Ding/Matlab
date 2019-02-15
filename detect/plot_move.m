start_tic = tic;
close all

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
plot(N, a, 'k');
plot(N(end), a(end), 'kx')

N2 = N + 0.8*(itvl*4 - N(end));
plot(N2, a, 'k--');
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
ploty(ac, 'k:');

h = gca;
ylim([2 40] * mm)
xlim([1 1.1*T(end)]);
xlabel('$N$');
ylabel('$a/$mm');

h.YTick = [2 10 20 30 36] * mm;
yt = split(num2str(h.YTick*1000));
yt{end} = '$a_c$';
h.YTickLabel = yt;

dblarrow(gca, T([1 2]), [20 20]*mm);
h = text(mean(T(1:2)), 20*mm, '$T$');
h.VerticalAlignment = 'bottom';

grid off

%%
fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));

figure(1);
if strncmpi(mfilename, 'plot_', 5)
    pname = mfilename;  % mfilename(6:end) wont work.
    print(pname(6:end), '-depsc');
else
    set(1, 'windowstyle', 'docked')
end