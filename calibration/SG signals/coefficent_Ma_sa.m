start_test = tic;
close all;

files = {
    'AAAA071.mat'	%1
    'AAAA072.mat'	%2
    'AAAA074.mat'	%3
    'AAAA075.mat'	%4
    'AAAA076.mat'	%5
    'AAAA078.mat'	%6
    'AAAA080.mat'	%7
    'AAAA123.mat'	%8
    'AAAA126.mat'	%9
    'AAAA127.mat'	%10
    'AAAA128.mat'	%11
    'AAAA131.mat'	%12
};

sb = 2.03/2;
b = 1.517/2;
ob = sb - b;
r = 0.860/2;

ra = 0.102;
la = 2*sb -ra;
rb = 0.147;
lb = 2*sb -rb;

rc = 0.385;
rd = sb;
re = rc;

rf = rb;
lf = lb;
rg = ra;
lg = la;

lc = rc - ob;
ld = rd - ob;
le = lc;

for i = 1 %:length(files);
    load(files{i}, 'Time', 'WF', 'WQ', 'WY', 'WA', 'Peso');

    Ma = WF(:,1) * ra;
%     Ma = WF(:,2) * la - WQ(:,2) * (la-ob) + WY(:,2) * r ...
%         + Peso*(sb-ra+0.072) - WQ(:,1) * (la-sb-b) + WY(:,1) * r;
    Mb = WF(:,1) * rb;
%     Mb =  WF(:,2) * lb - WQ(:,2) * (lb-ob) + WY(:,2) * r ...
%         + Peso*(sb-rb+0.072) - WQ(:,1) * (lb-sb-b) + WY(:,1) * r;
    
    Mc = WF(:,1) * rc - WQ(:,1) * lc - WY(:,1)*r;
    Md = WF(:,1) * rd - WQ(:,1) * ld - WY(:,1)*r;
%     Md2 = WF(:,2) * rd + Peso*0.072 - WQ(:,2) * ld + WY(:,2)*r;
    Me = WF(:,2) * re - WQ(:,2) * le + WY(:,2)*r;    
   
    Mf = WF(:,2) * rf;
%     Mf = WF(:,1) * lf - WQ(:,1) * (lf-ob) - WY(:,1) * r ...
%         + Peso*(sb-rf-0.072) - WQ(:,2) * (lf-sb-b) - WY(:,1) * r;
    Mg = WF(:,2) * rg;
%     Mg =  WF(:,1) * lg - WQ(:,1) * (lg-ob) - WY(:,1) * r ...
%         + Peso*(sb-rg-0.072) - WQ(:,2) * (lg-sb-b) - WY(:,1) * r;
end

subplot(2,2,1);
plotyy(Time, Mc, Time, WA(:,3));
subplot(2,2,2);
plotyy(Time, Md, Time, WA(:,4));

pp = abs(WA(:,3)) > 0.1;
Cc = zeros(size(Mc));
Cc(pp) = Mc(pp) ./ WA(pp,3);
subplot(2,2,3);
plot(Time, Cc);


pp = abs(WA(:,4)) > 0.1;
Cd = zeros(size(Md));
Cd(pp) = Md(pp) ./ WA(pp,4);
subplot(2,2,4);
plot(Time, Cd);

toc(start_test);