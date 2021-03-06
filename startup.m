start_tic = tic;

format shortG;
format compact;
% parpool('local', 4);

addpath(genpath([pwd, '\utilities']));

%% endcoding
% slCharacterEncoding('UTF-8');

%% graphical default setting
% set(groot, 'DefaultFigureWindowStyle', 'docked');
set(groot, 'DefaultFigureUnit', 'centimeter');
set(groot, 'DefaultFigurePosition', [1 15 8 6]);
set(groot, 'DefaultFigureColor', 'w');

set(groot, 'DefaultAxesNextPlot', 'add');   % hold on
set(groot, 'DefaultAxesXGrid', 'on');       % grid on
set(groot, 'DefaultAxesYGrid', 'on');
set(groot, 'DefaultAxesBox', 'on');
% set(groot, 'DefaultTextFontName','???');

%default background color
set(groot, 'DefaultAxesColor', 'none');
set(groot, 'DefaultLegendColor', 'none');
set(groot, 'DefaultLegendBox', 'off');

% default size
set(groot, 'DefaultLineLineWidth', 1);
set(groot, 'DefaultLineMarkerSize', 8);
set(groot, 'DefaultAxesFontsize', 10);
set(groot, 'DefaultTextFontsize', 10);
set(groot, 'DefaultLegendFontsize', 10);

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
