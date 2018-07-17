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
nr = 1e6;

h = gca;
h.XTick = [nr];
h.XTickLabel = {'$n$'};
h.YTick = [ar];
h.YTickLabel = {'$d$'};


%%
pda = U.pda(nr);
pdn = U.pdn(ar);

color = 0.5 * [1,1,1];

ax = linspace(U.n2a_a0(nr,a0(1)), U.n2a_a0(nr, a0(end)));
ay = pda.pdf(ax);
k = 1.5e5/max(ay);
ay = k*ay + nr;
plot([nr nr], ax([1 end]),  'k:');

i = ax >= ar;
h = fill([ay(i) nr], [ax(i) ar], color);
h.FaceAlpha = 0.7;
h.LineStyle = 'none';
plot(ay, ax, 'k');

nx = linspace(U.a2n_a0(ar,a0(end)), 1.1*U.a2n_a0(ar, a0(1)));
ny = pdn.pdf(nx);
k = 0.6e-3/max(ny);
ny = k*ny+ar;
plot(nx([1 end]), [ar ar], 'k:');

i = nx <= nr;
h = fill([nx(i) nr], [ny(i) ar], color);
h.FaceAlpha = 0.7;
h.LineStyle = 'none';
plot(nx, ny, 'k');

%%
fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));