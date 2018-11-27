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
WA = compress(WA, 500);
FY = compress(FY, 500);

subplot(3,1,1);
plot(Time, WA(:,1), 'k', Time, WA(:,4), 'k-.');
ylabel('$\mu\varepsilon$');
ylim([80 200]);
xlim([50 70]);
legend({"$A$", "$D$"}, 'location', 'e');

subplot(3,1,2);
plot(Time, WA(:,5), 'k', Time, WA(:,6), 'k-.');
ylabel('$\mu\varepsilon$');
ylim([250 370])
xlim([50 70]);

legend({"$E$", "$F$"}, 'location', 'se');

subplot(3,1,3);
plot(Time, FY, 'k');
ylabel('Load/kN');
xlim([50 70]);
ylim([-2 15])
xlabel('Time/s');
legend({"$F_Y$"}, 'location', 'ne');

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));