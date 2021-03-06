start_test = tic;
clf;
U = U_calc;

relative = true;
%%
% original from Lucchini
% E1 = 4.356743078628495e+004, E2 = 8.716744601440540e+004
% Uo = [
%     -2.686726154670896   3.364596960245444  -0.018423174324946  -0.043461241546464
% 	 0.183195308682250   0.286275884183867   4.402696179886554  -0.524075333851218
% ];

%{
% E1 = 8.346562701364707e+004, E2 = 9.680943578111116e+004
U = [
  -0.787431978995262   6.450385289539474   0.228319941870928   0.338740753880433
  -0.009255911042446  -0.008793093260635   3.325819159248064  -2.211916856603451
];

% E1 = 4.494403559767667e+004, E2 = 1.321877458939059e+005
U = [
  -2.515423722258881   3.724885585926641   0.136899071518633   0.205237403889375
   0.083490654958259   0.137079436056695   1.994704400485349  -4.267280040039738
];

% E1 = 7.220814048440690e+004, E2 = 9.695302728739848e+004
U = [
  -1.094757603985009   5.979286652095774   0.096731582834553   0.139570300618917
   0.493702270168952   0.785254067620691   3.675348720935722  -1.797500126033778
];

% E1 = 4.560198042649937e+004, E2 = 9.696078309303828e+004
U = [
  -2.543076239450694   3.712136525597317   0.192647190855457   0.291845888980255
   0.020821475739451   0.038014076685565   3.292384405681454  -2.245105974806981
];

%  E1 = 4.3832e+04 E2 = 8.7759e+04
U = [
  -2.541427671859754   3.560891568301269  -0.010428069509954  -0.035206876324308
   0.080327549885592   0.129891557583419   4.243733267869747  -0.723923489246709
];
%}

%%
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

T = [];
mt = 0;

YC = [];
WC = [];

for i = 1:length(files);
    load(files{i}, 'Time', 'WY', 'WW', 'phi');
    T = [T; mt + Time];
    mt = T(end);
    [i, mt]
    
    YC = [YC; WY];
    WC = [WC; WW];
end

YS = WC * U';
%%
if relative
    YC = YC(:,1) + YC(:,2);
    YS = YS(:,1) + YS(:,2);
    E = YC - YS;
    subplot(2,1,1)
    plot(T, E, 'LineWidth',2),grid on
    axis ([0 T(end) min(E)-5 max(E)+5])
    ylabel('[kN]'), legend('absolute error')

    E_rel = abs(E ./ YC);
    E_rel(abs(YC) < .5) = 0;
    subplot(2,1,2)
    plot(T, E_rel, 'LineWidth',2),grid on
    xlim([0 T(end)])
    xlabel('Time [s]'),ylabel('[%]'), legend('relative error')
else
    subplot(3,1,1)
    plot(T,YC(:,1),'k',T,YS(:,1),'b--','LineWidth',2),grid
    axis ([0 T(end) min(YC(:,1))-5 max(YC(:,1))+5])
    xlabel('Time [s]'),ylabel('[kN]'),legend('Y1 real','Y1 calc')

    subplot(3,1,2)
    plot(T,YC(:,2),'k',T,YS(:,2),'r--','LineWidth',2),grid
    axis ([0 T(end) min(YC(:,2))-5 max(YC(:,2))+5])
    xlabel('Time [s]'),ylabel('[kN]'),legend('Y2 real','Y2 calc')

    subplot(3,1,3)
    plot(T,YC(:,1)+YC(:,2),'k',T,YS(:,1)+YS(:,2),'m--','LineWidth',2),grid
    axis ([0 T(end) min(YC(:,1)+YC(:,2))-5 max(YC(:,1)+YC(:,2))+5])
    xlabel('Time [s]'),ylabel('[kN]'),legend('Y1+Y2 real','Y1+Y2 calc')
end


toc(start_test);