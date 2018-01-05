start_test = tic;
clf;

i = 17;
% i = 13;

files = {
    'AAAA017rid.mat'	%1
    'AAAA018rid.mat'	%2
    'AAAA035rid.mat'	%3
    'AAAA038rid.mat'	%4
    'AAAA044rid.mat'	%5
    'AAAA046rid.mat'	%6
    'AAAA047rid.mat'	%7
    'AAAA061rid.mat'	%8
    'AAAA063rid.mat'	%9
    'AAAA064rid.mat'	%10
    'AAAA067rid.mat'	%11
    'AAAA069rid.mat'	%12
    'AAAA070rid.mat'	%13
    'AAAA106rid.mat'	%14
    'AAAA109rid.mat'	%15
    'AAAA111rid.mat'	%16
    'AAAA114rid.mat'	%17
    'AAAA115rid.mat'	%18
};

load(files{i}, 'WY', 'WW', 'Time', 'fsamp');
% if i < 9
    WY = WY(:, 2);
    WW = WW(:, 3:4);
%     
% %   U = [-2.665539563507801   3.398200106467114];
%     U = [-2.973178370983463   2.766220676625247];
% else
%     WY = WY(:, 2);
%     WW = WW(:, 3:4);
%     
%     U = [4.408829396061532  -0.513146765453975];
% end
% Time = Time(1:I);

U = (WW \ WY)'

% [b,bint,r,rint,stats] = regress(WY, [ones(length(WW), 1) WW]);
% b, bint, stats

YC = WY;%(:,1) + WY(:,2);
YS = WW * U';
% YS = YS(:,1) + YS(:,2);
E = YC - YS;
    
subplot(2,1,1);
plot(Time, YC, 'r', Time, YS, 'b--', 'LineWidth', 2); grid on
xlabel('Time [s]');
ylabel('Load [kN]');
% if i < 9
%     legend('Y_1参考值','Y_1计算值')
%     title('标定工况10')
% else
%     legend('Y_2参考值','Y_2计算值', 'Location', 'NW');
%     title('标定工况11')
% end

subplot(2,1,2);
RE = E ./ YC;
RE(abs(YC) < .5) = nan;
plot(Time, E); grid on

toc(start_test);
