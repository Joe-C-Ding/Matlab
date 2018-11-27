start_tic = tic;
% close all but one figure, or creat one if none is there.
h = get(groot, 'Children');
if length(h) > 1
    i = ([h.Number] == 1);
    close(h(~i)); h = h(i);
end
clf(h);

i = 12;
I = 2;

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

load(files{i}, 'WQ', 'WA', 'Time', 'FY');
U = (WA \ WQ)';

Time = compress(Time, 500);
WQ = compress(WQ, 500);
WA = compress(WA, 500);
FY = compress(FY, 500);

QS = WQ(:,I);
QC = WA*U';
QC = QC(:,I);
E = QS-QC;
RE = E./QS;

% subplot(2,1,1);
plot(Time, QS, 'k-.', Time, QC, 'k');
legend({"$Q_{2,\rm ref}$", "$Q_{2,\rm calc}$"}, 'location', 'se');

ylabel('Load/kN');

xlim([50 70]);

xlabel('Time/s');


fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));