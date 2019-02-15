start_tic = tic;
close all

h = gca;
xlim([0 1]); h.XTick = 0:0.2:1;
ylim([0 1]); h.YTick = 0:0.2:1;

a = 10; b = 2;
pd = prob.NormalDistribution();

conf = 0.8;
z = pd.icdf(1-conf);

x = linspace(0, 1);
X = pd.icdf(1-x);
Y = 2*z - X;
y = 1-pd.cdf(Y);
y(end) = 0;

% fill( ... % C
%     [1, conf, conf, 0, 0, x], ...
%     [0, 0, conf, conf, 1, y], ...
%     156/256 * [1 1 1], 'LineStyle', 'none' ...
% );
% fill( ... % D
%     [x, 1, 1, conf, conf, 0], ...
%     [y, 0, conf, conf, 1, 1], ...
%     207/256 * [1 1 1], 'LineStyle', 'none' ...
% );

plot([conf conf], [0 1], 'k--');
hr = plot([0 1], [conf conf], 'k--');
hxy = plot(x, y, 'k');

grid off;
h = legend([hxy, hr], '$D_1+D_2=d_1+d_2$', '$R=0.8$');
h.Location = 'southwest';
% h.FontSize = 12;
xlabel('$D_1 / u$'); ylabel('$D_2 / v$');
daspect([1 1 1]);

text(0.4, 0.4, '$A$');
text(0.9, 0.9, '$B$');

text(0.6, 0.85, '$C$');
text(0.7, 0.93, '$D$');
text(0.88, 0.58, '$C''$');
text(0.93, 0.7, '$D''$');

%%
fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));

figure(1);
if strncmpi(mfilename, 'plot_', 5)
    pname = mfilename;  % mfilename(6:end) wont work.
    print(pname(6:end), '-depsc');
else
    set(1, 'windowstyle', 'docked')
end