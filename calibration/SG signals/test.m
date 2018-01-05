start_test = tic;
clf;

i = 12;
side = 2;
inter = (25001-100):35001;

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

load(files{i});
U = (WA \ WQ)'

b = ones(1,100)/100;
WA = WA(inter,:);
WQ = WQ(inter,:);
WQ = filter(b, 1, WQ);
Time = Time(inter,:);
FY = filter(b, 1, FY(inter,:));

QS = WQ(:,side);
QC = WA*U';
QC = QC(:,side);

E = QS-QC;
RE = E./QS;

subplot(3,1,1);
plot(Time, QS, 'r', Time, QC, 'b--'); grid on
% xlim([45 75]);
% ylim([44 50]);

subplot(3,1,2);
plot(Time, WA); grid on;

subplot(3,1,3);
plot(Time, FY);

xlabel('Time [s]');
% xlim([45 75]);
% ylim([-10 3]);

toc(start_test);
