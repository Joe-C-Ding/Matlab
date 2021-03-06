start_tic = tic;

file = 'rainflow/other/QYcycles_200.xlsx';
[pathstr,name,ext] = fileparts(file);

if ~isempty(regexpi(name, 'rainflow'))
    type = 1;
elseif ~isempty(regexpi(name, 'QY'))
    type = 2;
end

if type == 1
    A = zeros(300,2,14);
    for j = 1:14
        A(:,:,j) = xlsread(file, j);
    end
    save([pathstr '/' name '.mat'], 'A', '-append');
    
elseif type == 2
    QY = zeros(241, 241, 2);
    QY(:,:,1) = xlsread(file,1);
    QY(:,:,2) = xlsread(file,2);
    
    save([pathstr '/' name '.mat'], 'QY', '-append');
end

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));