start_tic = tic;

format shortG;
format compact;
% parpool('local');

addpath(genpath([pwd, '\utilities']));
set(groot,'DefaultFigureWindowStyle','docked');

if exist('startup.mat', 'file')
    load startup.mat
    
    fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));
    clear start_tic;
else
    global diameter;
    diameter = 860;
    
    tkm2r = pi * diameter / 1e10;
    Hz2kph = 3.6 * pi * diameter / 1000;

    fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));
    clear start_tic;
    save startup.mat
end
