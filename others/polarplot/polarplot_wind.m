clear all
close all

start_tic = tic;


% gcf;    % make sure figure1 is exsist
% clf(1); ax = axes('parent', 1);
% hold(ax, 'on');
% grid(ax, 'on');

data = importdata('data.txt');

% make time
s = strcat(data.textdata(:, 1), 'T', data.textdata(:, 2));
time = datetime(s, 'InputFormat', 'yyyy-MM-dd''T''HH:mm:ss');

% plot data
figure;
plot(time, data.data(:, 2));
grid on;
ylabel('wind speed [m/s]');
ylim([0 3]);
ax = gca;
ax.XTickLabelRotation = 45;


% polarplot
figure;
polarplot(deg2rad(data.data(:,1)), data.data(:,2), '*-')
ax = gca;
ax.ThetaZeroLocation = 'top';
ax.RAxisLocation = 320;


fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));