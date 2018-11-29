start_tic = tic;
% close all but one figure, or creat one if none is there.
h = get(groot, 'Children');
if length(h) > 1
    i = ([h.Number] == 1);
    close(h(~i)); h = h(i);
end
clf(h);

load ../spectrum.mat

i = 4;

s = stress;
ds = s(2) - s(1);
n = numbers(:, i);
N = sum(n);

f = n/N/ds;
F = cumtrapz(s, f);
plot(s, f);
xlim([25 40]);

u0 = 45;
ui = find(s>=u0, 1);
ue = 255;%find(F>=1-1e-6, 1);
[ui ue]
F0 = F(ui);

uu = s(ui:ue);
cdf = F(ui:ue);
Fu = (F(ui:ue)-F0) / (1-F0);

figure;
eu = mean_excess_u([uu Fu]);
plot(uu, eu);
xticks(25:2:70);
xtickangle(90);

figure;
pd2 = edfu([uu Fu], u0);
plot(uu, Fu, 'r', uu, pd2.cdf(uu));

max(abs(Fu - pd2.cdf(uu)))

% legend(name{group{i}});
% 
% set(gca, 'XScale', 'log');
% xlim([10 1e7]);
% xlabel('cumulative numbers');
% xticks(10.^(1:7))
% ylim([10 80]);
% yticks(20:10:80);
% ylabel('stress/MPa');

%%
% pd = prob.NormalDistribution(100, 25);
% % pd = prob.WeibullDistribution(10, 5);
% % pd = prob.ExponentialDistribution(5);
% 
% u = linspace(pd.icdf(0.3), pd.icdf(0.99)).';
% 
% up = 0.5;
% u0 = pd.icdf(up);
% 
% uu = u(u>u0);
% Fu = (pd.cdf(uu)-up) / (1-up);
% 
% pd2 = edfu([uu Fu], u0);
% plot(uu, Fu, 'r', uu, pd2.cdf(uu));

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));