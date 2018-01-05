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

%                 P Q R S
chose = logical([ 1 1 1 1 ]);

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
    E = [E; WW(:,chose)];
    
    TimeAxis = [TimeAxis; TAend + Time];
    TAend = TimeAxis(end);
end

u = (E\F)';
U_calc(:,chose) = u

[b,bint,r,rint,stats] = regress(F(:,1), [ones(length(E), 1) E]);
b, bint, stats
[b,bint,r,rint,stats] = regress(F(:,2), [ones(length(E), 1) E]);
b, bint, stats


res_calc = E * u';
R_1 = norm(F(:,1)-res_calc(:,1))
R_2 = norm(F(:,2)-res_calc(:,2))
R_calc = norm(F(:)-res_calc(:))

Error = res_calc - F;

subplot(2,1,1);
plot(TimeAxis, res_calc(:,1), 'k--', TimeAxis, F(:,1), 'g', 'LineWidth', 2); grid on;
% xlabel('Time [s]');
ylabel('Force [kN]');
% title('Y_1 calculated by yours U_{calc}');
legend('Y_1 calc','Y_1 ref', 'Location', 'SE');
xlim([0 TAend]);

subplot(2,1,2);
plot(TimeAxis, Error(:,1), 'r', [0 TAend], [0 0], 'k:', 'LineWidth', 2); grid on;
% plot(TimeAxis, res_calc(:,2), 'r', TimeAxis, F(:,2), 'k', 'LineWidth', 2);
xlabel('Time [s]'), ylabel('Error [kN]')..., title('Y_2 calculated by yours U_{calc}');
% legend('Y_2 calc', 'Y_2 ref', 'Location', 'SE');
ylim([-5.5 3]);
xlim([0 TAend]);


toc(start_test);