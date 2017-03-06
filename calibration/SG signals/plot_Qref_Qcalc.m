start_test = tic;

i = 10;
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

% load U.mat
U = U_calc;
% U = (WA \ WQ)'

[b,bint,r,rint,stats] = regress(WQ(:,I), [ones(length(WA), 1) WA]);
b', bint', stats

Time = compress(Time, 500);
WQ = compress(WQ(:,I), 500);
WA = compress(WA, 500);
FY = compress(FY, 500);

subplot(2,1,1);
plot(Time, WQ, 'r', Time, WA*U(I,:)', 'b--', 'LineWidth', 2); grid on
ylabel(['Q_' num2str(I) ' [kN]']);
legend(['Q_' num2str(I) ' ref'], ['Q_' num2str(I) ' calc'], ...
    'Location', 'NE', 'Orientation', 'horizontal');
title(['标定工况' num2str(i)]);

xlim([45 75]);
ylim([44 50]);

subplot(2,1,2);
plot(Time, FY, 'b', 'LineWidth', 2); grid on;
xlim([45 75]);
ylabel('FY [kN]'); 
legend('FY', 'Location', 'SE');

xlabel('Time [s]');
xlim([45 75]);
ylim([-10 3]);

toc(start_test);
