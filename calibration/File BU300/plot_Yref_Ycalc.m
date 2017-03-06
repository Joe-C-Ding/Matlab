start_test = tic;

% i = 6; contact = 'Left';
i = 13; contact = 'Right';

files = {
    'AAAA017rid.mat'	%1 'Left'
    'AAAA035rid.mat'	%2 'Left'
    'AAAA038rid.mat'	%3 'Left'
    'AAAA061rid.mat'	%4 'Left'
    'AAAA063rid.mat'	%5 'Left'
    'AAAA064rid.mat'	%6 'Left'
    'AAAA106rid.mat'	%7 'Left'
    'AAAA109rid.mat'	%8 'Left'
    'AAAA018rid.mat'	%9 'Right'
    'AAAA044rid.mat'	%10 'Right'
    'AAAA046rid.mat'	%11 'Right'
    'AAAA047rid.mat'	%12 'Right'
    'AAAA067rid.mat'	%13 'Right'
    'AAAA069rid.mat'	%14 'Right'
    'AAAA070rid.mat'	%15 'Right'
    'AAAA111rid.mat'	%16 'Right'
    'AAAA114rid.mat'	%17 'Right'
    'AAAA115rid.mat'	%18 'Right'
};

load(files{i}, 'WY', 'WW', 'Time', 'fsamp');
if strcmpi(contact, 'Left')   
    [M I] = max(abs(WY(:,1)));
    I = I + 2.5*fsamp;
    WY = WY(1:I, 1);
    WW = WW(1:I, 1:2);
    
%   U = [-2.665539563507801   3.398200106467114];
    U = [-2.973178370983463   2.766220676625247];
else
    [M I] = max(abs(WY(:,2)));
    I = I + 2.5*fsamp;
    WY = WY(1:I, 2);
    WW = WW(1:I, 3:4);
    
    U = [4.408829396061532  -0.513146765453975];
end
Time = Time(1:I);

% U = (WW \ WY)'

[b,bint,r,rint,stats] = regress(WY, [ones(length(WW), 1) WW]);
b, bint, stats

plot(Time, WY, 'r', Time, WW*U', 'b--', 'LineWidth', 2); grid on
xlabel('Time [s]');
ylabel('Load [kN]');
if strcmpi(contact, 'Left')
    legend('Y_1参考值','Y_1计算值')
   title('标定工况10')
else
    legend('Y_2参考值','Y_2计算值', 'Location', 'NW')
    title('标定工况11')
end

toc(start_test);
