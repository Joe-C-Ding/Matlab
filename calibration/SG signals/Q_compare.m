start_test = tic;

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

% construct the eqution with the form of 'F = EU'
F = [];     % in which, 'F' represents the loads (i.e. Q1 & Q2).
E = [];     % 'E' represents the signals on axle (i.e. channel A, B etc.).

TimeAxis = [];  % used to plot figure.
TAend = 0;

U_calc = zeros(2, 4);

for i = 1:M
    load(files{i}, 'WQ', 'WA', 'Time');

    F = [F; WQ];
    E = [E; WA];
    
    TimeAxis = [TimeAxis; TAend + Time];
    TAend = TimeAxis(end);
end

load U.mat

res_tot = E * Utot';
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