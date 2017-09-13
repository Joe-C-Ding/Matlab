start_test = tic;
gcf;
clf(1); ax = axes('parent', 1);
hold(ax, 'on');
grid(ax, 'on');

relative = true;

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

if relative
    E = F - res_calc;
    E_rel = E ./ F;
    
    subplot(2,1,1);
    plot(TimeAxis, E(:,1), TimeAxis, E(:,2), 'LineWidth', 2);
    grid on;
    ylabel('error [kN]');
    legend('Q_1', 'Q_2', 'Location', 'NE');
    xlim([0 TAend]);
    
    subplot(2,1,2);
    plot(TimeAxis, E_rel(:,1), TimeAxis, E_rel(:,2), 'LineWidth', 2);
    grid on;
    ylabel('relative error [%]');
    legend('Q_1', 'Q_2', 'Location', 'NE');
    xlim([0 TAend]);
else
    subplot(2,1,1);
    plot(TimeAxis, F(:,1), 'g', TimeAxis, res_calc(:,1), 'k--', 'LineWidth', 2);
    grid on;
    ylabel('Q_1 [kN]');
    legend('Q_{1 calc}', 'Q_{1 ref}', 'Location', 'NW');
    xlim([0 TAend]);
    
    subplot(2,1,2);
    plot(TimeAxis, F(:,2), 'g', TimeAxis, res_calc(:,2), 'k--', 'LineWidth', 2);
    grid on;
    ylabel('Q_2 [kN]');
    legend('Q_{2 calc}', 'Q_{2 ref}', 'Location', 'NW');
    xlim([0 TAend]);
end

toc(start_test);
