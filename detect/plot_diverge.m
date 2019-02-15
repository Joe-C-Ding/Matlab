start_tic = tic;
close all

C = 1.82e-13;
m = 2.6465;
mm = 1e-3;

s = [80 70 65];
a0 = 2 * mm;
ac = 36 * mm;

a = cell(3,1);
N = cell(3,1);
for i = 1:length(s)
    tC = C * (s(i)*sqrt(pi))^m;
    a2N = @(a) 2*(a(1)^(1-m/2) - a.^(1-m/2))/tC/(m-2);

    ta = (a0^(1-m/2) - tC*(m-2)*logspace(0,8)/2).^(2/(2-m));
    ta = sort([ta linspace(a0, ac, 50)]);
    ta(ta>ac) = [];
    
    a{i} = ta;
    N{i} = a2N(ta);
end

itvl = N{2}(end)/4;
T = itvl*[1 2 3 4 5];

line = ["k--", "k", "k-."];
for i = 1:length(s)
    plot(N{i}, a{i}, line(i));
    plot(N{i}(end), a{i}(end), 'kx')
    
    a1 = interp1(N{i}, a{i}, T);
    a1(a1 == ac) = nan;
    poda(a1);
    h = plot(T, a1, 'ko');
    h.MarkerSize = 6;
end

ylim([2 36] * mm)
plotx(T, 'k:')
ploty(ac, 'k:');

h = gca;
ylim([2 40] * mm)
xlim([1 1.1*N{3}(end)]);
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