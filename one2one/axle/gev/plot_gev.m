get_ready();

load ../spectrum.mat

i = 2;

s = stress;
ds = s(2) - s(1);
n = numbers(:, i);
N = sum(n);

f = n/N/ds;
F = cumtrapz(s, f);
plot(s, f);
xlim([25 50]);

u = [30 38 43 45 49 38 32];
u0 = u(i);
ui = find(s>=u0, 1);
ue = find(F>=1-1e-6, 1);
if isempty(ue)
    ue = find(s>70, 1);
end
% [ui ue]
F0 = F(ui);

uu = s(ui:ue);
cdf = F(ui:ue);
Fu = (F(ui:ue)-F0) / (1-F0);

figure;
eu = mean_excess_u([uu Fu]);
plot(uu, eu, 'k');
xticks(26:2:70);
xlim([u0 s(ue)]);
xtickangle(90);
ylabel('$e(u)/$MPa');
xlabel('$u/$MPa')

figure;
pd2 = edfu([uu Fu], u0);
plot(uu, Fu, 'k', uu, pd2.cdf(uu), 'k-.');
legend({"$F_u(s)$", "G(s)"}, 'location', 'se');
xlabel('$s/$MPa');
xlim([u0 s(ue)]);
% ylim([0.9 1])

s_max = pd2.icdf(1 - 1e-6/(1-F0));

[u0, pd2.k, pd2.sigma, norm(Fu-pd2.cdf(uu), inf), s_max]
% fprintf('s_max = %.3f\tu+s_max = %.3f\n', s_max-u0, s_max);

end_up(mfilename, {});