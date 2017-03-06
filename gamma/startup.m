startupID = tic;
format shortG;
% matlabpool local 4;

if exist('startup.mat', 'file')
    load startup.mat
    
    toc(startupID);
    clear startupID;   
else
    global Du a b l diameter interval POD;
    Du = 55;
    diameter = 860;
    interval = 1;
    
    bN0 = fcgpath(Du+5, 0.1, 0.05);
    bN1 = fcgpath(Du+5, 0.1, 0.5);
    bN2 = fcgpath(Du+5, 0.1, 0.95);
    bN = [bN0; bN1; bN2];
    
    [a, b, l] = estgamma3(bN1);

    POD = xlsread('POD.xls', 1, 'A1:B99');
    
    phi = @(x) 0.5 + 0.5*erf( x / sqrt(2) );

    toc(startupID);
    clear startupID;
    save startup.mat
end