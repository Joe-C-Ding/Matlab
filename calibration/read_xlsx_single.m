start_tic = tic;

i = 8;
file = ['rainflow/weight/' list{i}];
[pathstr,name,ext] = fileparts(file);
savepath = pwd;
cd(pathstr);

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
    save([name '.mat'], 'A');
    
elseif type == 2
    QY = zeros(241, 241, 2);
    QY(:,:,1) = xlsread(file,1);
    QY(:,:,2) = xlsread(file,2);
    
    save([name '.mat'], 'QY');
end
cd(savepath);

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));