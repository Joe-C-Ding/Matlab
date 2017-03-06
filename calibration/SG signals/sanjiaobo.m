start_tic = tic;
ax = cla('reset');

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
M = length(files);

i = 1;
% for i = 1:1
    load(files{i}, 'WW', 'P', 'Time', 'FY', 'v', 'fsamp');

%     F = [F; WQ];
%     E = [E; WA(:,chose)];
%     
%     TimeAxis = [TimeAxis; TAend + Time];
%     TAend = TimeAxis(end);
% end

f = mean(v2f(v));
s = floor(fsamp/4/f);
PP = P - WW(:,1);
P2 = [zeros(s,1); PP(1:end-s, 1)];


% p = find(Time > 19 & Time <= 21);
% mp = mean(P(p))

plot(ax, Time, P, 'b', Time, abs(PP) + abs(P2)+WW(:,1));
xlim([19 19.5]);

toc(start_tic);