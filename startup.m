start_tic = tic;

format shortG;
format compact;
% parpool local 4;

addpath(genpath([pwd, '\utilities']));

%% graphical default setting
set(groot, 'DefaultFigureWindowStyle', 'docked');
set(groot, 'DefaultAxesNextPlot', 'add');   % hold on
set(groot, 'DefaultAxesXGrid', 'on');       % grid on
set(groot, 'DefaultAxesYGrid', 'on');
set(groot, 'DefaultAxesBox', 'on');

% default size
set(groot, 'DefaultLineLineWidth', 2);
set(groot, 'DefaultLineMarkerSize', 8);
set(groot, 'DefaultAxesFontsize', 12);
set(groot, 'DefaultTextFontsize', 12);
set(groot, 'DefaultLegendFontsize', 12);

% default latex
set(groot, 'DefaultTextInterpreter', 'latex');
set(groot, 'DefaultTextHorizontalAlignment', 'center');
set(groot, 'DefaultAxesTickLabelInterpreter', 'latex');
set(groot, 'DefaultLegendInterpreter', 'latex');

%% load `startup.mat` or create it.
if exist('startup.mat', 'file')
    load startup.mat
    
    fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));
    clear start_tic;
else
    global diameter;
    diameter = 860;
    
    tkm2r = 1e10 / pi / diameter;
    Hz2kph = 3.6 * pi * diameter / 1000;

    fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));
    clear start_tic;
    save startup.mat
end
