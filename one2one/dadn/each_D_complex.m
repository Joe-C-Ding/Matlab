get_ready(true);

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
a0 = [1 1.2 1.3]*mm;
U = crack([1 1.3]*mm, C, m, s);

n = linspace(0, 2e6).';
a = U.n2a_a0(n, a0);
plot(n, a, 'k:');

ylim([1 5]*mm)
% xlabel('$N$');
% ylabel('$D$');
grid off;

ar = 4 * mm;
nr = 5e5;

%%
k = 2;

pda = U.pda(nr);

ax = linspace(U.n2a_a0(nr,a0(1)), U.n2a_a0(nr, a0(end)));
ay = pda.pdf(ax);
fac = 1.5e5/max(ay);
ay = fac*ay + nr;
plot([nr nr], ax([1 end]),  'k--');

i = ax >= ar;
plot(ay, ax, 'k');

ht = text(ay(1), 0.95*min(ax), sprintf('$D_%d$', k));
ht.VerticalAlignment = 'top';

%%
h = gca;
h.XTick = [nr];
h.XTickLabel = {sprintf('$n_%d$', k)};
xlabel('Cycels');
ylabel('Damage');
yticks([]);
title(sprintf('Stress level $S_%d$', k))

set(gcf, 'Color', [1 1 1]);

end_up(mfilename)