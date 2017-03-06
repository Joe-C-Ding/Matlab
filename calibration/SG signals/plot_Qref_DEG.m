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

load(files{i},  'WA', 'Time');

Time = compress(Time, 500);
D = compress(WA(:,4), 500);
E = compress(WA(:,5), 500);
G = compress(WA(:,7), 500);

subplot(3,1,1);
plot(Time, D, 'r', 'LineWidth', 2); grid on
ylabel(['D (strain)']);
title(['标定工况' num2str(i)]);
xlim([45 75]); ylim([166 190]);

subplot(3,1,2);
plot(Time, E, 'b', 'LineWidth', 2); grid on;
ylabel(['E (strain)']);
xlim([45 75]); ylim([130.5 135]);

subplot(3,1,3);
plot(Time, G, 'k', 'LineWidth', 2); grid on;
xlabel('Time [s]'); ylabel(['G (strain)']);
xlim([45 75]); ylim([108 117]);

toc(start_test);
