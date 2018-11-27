start_tic = tic;
% close all but one figure, or creat one if none is there.
h = get(groot, 'Children');
if length(h) > 1
    i = ([h.Number] == 1);
    close(h(~i)); h = h(i);
end
clf(h);

%% paras
mt = 17000;
m2 = 1422;
m1 = mt - m2;
g = 9.81;

b = 1015;
s = 746.5;
h1 = 1280;
R = 430;
Rb1 = 282;  % radius of wheel brake
Rb2 = 272;  % radius of axle brake

Ff = 45000;
Gam = 0.35;
Fi = 1353;
y1 = 396.5;
y2 = 1096.5;

%% calc other paras.
P1 = (0.625+0.0875*h1/b)*m1*g;
P2 = (0.625-0.0875*h1/b)*m1*g;
Y1 = 0.35*m1*g;
Y2 = 0.175*m1*g;
H = Y1 - Y2;

Q1 = (P1*(b+s) - P2*(b-s) + H*R - Fi*(y1+y2))/2/s;
Q2 = (P2*(b+s) - P1*(b-s) - H*R - Fi*(y1+y2))/2/s;

%% calc result
ylft = linspace(0, b-s-1, 10);
yin1 = linspace(b-s, b-s+y1-1, 10);
yin2 = linspace(b-s+y1, b-s+y2-1, 10);
yin3 = linspace(b-s+y2, b+s-1, 10);
yrit = linspace(b+s, 2*b, 10);
yin = [yin1, yin2, yin3];
y = [ylft, yin, yrit];

Mx = [P1*ylft, ...
      P1*yin-Q1*(yin-b+s)+Y1*R-2*Fi*(yin-b), ...
      P2*(2*b-yrit)];
plot(y, Mx, 'r');

Mxp = Ff*Gam * [ylft, yin1, (b-s+y1)*ones(size(yin2)), 2*b-[yin3, yrit]];
plot(y, Mxp, 'b');

Mzp = Ff*Gam*Rb2/R * [ylft, (b-s)*ones(size(yin)), 2*b-yrit];
plot(y, Mzp, 'color',[1 0.5 0]);

Myp = [zeros(size(ylft)), 0.3*P2*R*ones(size(yin)), zeros(size(yrit))];
plot(y, Myp, 'color',[0 0.7 0.35]);

MR = sqrt((Mx+Mxp).^2 + Mzp.^2 + Myp.^2);
plot(y, MR, 'k');

%% adjust plot
h = gca;
h.YAxis.Exponent = 6;
yticks(0:5e6:65e6);
ylim([0 65e6]);

xticks(0:200:y(end));
xtickangle(90);
xlim(y([1 end]));

ylabel('Moments/[Nmm]');
xlabel('Abscissa for the section/[mm]');

%% postion
pos = [69 95.5 143 268.5 345 385 555 600 665 735 775 1015 1645].';
mr = interp1(y, MR, pos);
% [pos mr]

dp = 60;
d = [130 129.8 159.8 212 212 180 180 214 214 214 180 180 180].';
r = [inf 40 25 inf inf 75 75 inf inf inf 75 inf 75].';
D = [130 160 277 212 212 277 246 214 214 214 246 180 277].';

X = r./d;
Y = D./d;
A = (4-Y).*(Y-1)./(5*(10*X).^(2.5*X+1.5-0.5*Y));
k = 1 + A;

stress = 32/pi * k.*mr.*d ./ (d.^4-dp^4);
s_max = [85 180 180 99 99 180 180 99 99 99 180 180 180].';
safe = s_max./stress;

[pos mr stress s_max safe]

i = safe < 1.33;
[pos(i) mr(i) stress(i) s_max(i) safe(i)]

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));