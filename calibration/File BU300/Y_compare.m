start_test = tic;

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


M = length(files);

% construct the eqution with the form of 'F = EU'
F = [];     % in which, 'F' represents the loads (i.e. Q1 & Q2).
E = [];     % 'E' represents the signals on axle (i.e. channel A, B etc.).

TimeAxis = [];  % used to plot figure.
TAend = 0;

U_calc = zeros(2, 4);

for i = 1:M
    load(files{i}, 'WY', 'WW', 'Time');

    F = [F; WY];
    E = [E; WW];
    
    TimeAxis = [TimeAxis; TAend + Time];
    TAend = TimeAxis(end);
end

load U.mat

[b1,b1int,r,rint,stats1] = regress(F(:,1), [ones(length(E), 1) E(:,1:2)]);
b1, b1int, stats1
[b2,b2int,r,rint,stats2] = regress(F(:,2), [ones(length(E), 1) E(:,3:4)]);
b2, b2int, stats2

res_tot = E * Utot0';
res_pr = E * Upr0';
res_qs = E * Uqs0';

R_tot = norm(F(:)-res_tot(:)) 
R_pr = norm(res_tot(:)-res_pr(:))
R_qs = norm(res_tot(:)-res_qs(:))

res_d = res_pr;
res_r = res_tot;
subplot(2,1,1);
plot(TimeAxis, res_d(:,1), 'g', TimeAxis, res_r(:,1), 'k:', 'LineWidth', 2);
xlabel('Time [s]'), ylabel('Force [kN]');
legend('Y_1 reduce','Y_1 totle', 'Location', 'SE');

subplot(2,1,2);
plot(TimeAxis, res_d(:,2), 'r', TimeAxis, res_r(:,2), 'k:', 'LineWidth', 2);
xlabel('Time [s]'), ylabel('Force [kN]');
legend('Y_2 reduce', 'Y_2 totle', 'Location', 'SE');

toc(start_test);