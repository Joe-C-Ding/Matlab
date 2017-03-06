close all
home

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
%           A B C D E F G
chose = ~~[ 1 1 1 1 1 1 1 ];

% construct the eqution with the form of 'F = EU'
F = [];     % in which, 'F' represents the loads (i.e. Q1 & Q2).
E = [];     % 'E' represents the signals on axle (i.e. channel A, B etc.).

TimeAxis = [];  % used to plot figure.
TAend = 0;

U_calc = zeros(2,7);

for i = 1:M
    load(files{i}, 'WQ', 'WA', 'Time');

    F = [F; WQ];
    E = [E; WA(:,chose)];
    
    TimeAxis = [TimeAxis; TAend + Time];
    TAend = TimeAxis(end);
end

u = (E\F)';
U_calc(:,chose) = u

[b1,bint2,r,rint,stats] = regress(WQ(:,1), [ones(length(WA), 1) WA]);
b1', stats
[b2,bint2,r,rint,stats] = regress(WQ(:,2), [ones(length(WA), 1) WA]);
b2', stats

res_calc = E * u';
R_1 = norm(F(:,1)-res_calc(:,1))
R_2 = norm(F(:,2)-res_calc(:,2))
R_calc = norm(F(:)-res_calc(:))

Error = res_calc - F;

subplot(2,1,1);
plot(TimeAxis, F(:,1), 'g', TimeAxis, res_calc(:,1), 'k--', 'LineWidth', 2);
grid on;
% xlabel('Time [s]'); 
ylabel('Force [kN]');
% title('Q_1 calculated by yours U_{calc}');
legend('Q_1 calc', 'Q_1 ref', 'Location', 'NE');
ylim([30 120]); xlim([0 TAend]);

subplot(2,1,2);
plot(TimeAxis, Error(:,1), 'r', [0 TAend], [0 0], 'k:', 'LineWidth', 2);
grid on;
% plot(TimeAxis, res_calc(:,2), 'r', TimeAxis, F(:,2), 'k', 'LineWidth', 2);
xlabel('Time [s]');
ylabel('Error [kN]');
% title('Q_2 calculated by yours U_{calc}');
% legend('Q_2 calc', 'Q_2 ref', 'Location', 'SE');
xlim([0 TAend]);

toc(start_test);
