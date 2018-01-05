start_tic = tic;
figure(1);
clf; ax = gca;

pwd_save = pwd;

try 
    cd('rainflow/cut/');
    listing = dir('.');

%     s1 = '2014-07-';
%     tf = strncmp({listing.name}, s1, length(s1));
%     listing(~tf) = [];
    listing = {listing.name}';
catch ME
    fprintf('%s: %d\n', ...
        ME.identifier, ME.stack(end).line);
end

A = zeros(300,2,14);
QY = zeros(241, 241, 2);

for i = 1:length(listing)
    file1 = [listing{i} '/Rainflow_fix.xlsx'];
    file2 = [listing{i} '/QYcycles.xlsx'];
    
try
    for j = 1:14
        A(:,:,j) = xlsread(file1, j);
    end 
    
    QY(:,:,1) = xlsread(file2,1);
    QY(:,:,2) = xlsread(file2,2);
    
    save([listing{i} '.mat'], 'A', 'QY')
catch ME
    fprintf('%s: %s: %d\n', listing{i}, ...
        ME.identifier, ME.stack(end).line);
end

end

cd(pwd_save);

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));