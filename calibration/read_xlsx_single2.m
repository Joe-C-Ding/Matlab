start_tic = tic;

pathstr = 'rainflow/rainflow/';
list = dir([pathstr, '*.xlsx']);
list = {list.name}';

savepath = pwd;
cd(pathstr);

rainflow = zeros(256,3,2);
for i = 1:length(list)
    [~, file, ext] = fileparts(list{i});
    
    Q1 = xlsread(list{i}, 'Q1');
    Q2 = xlsread(list{i}, 'Q2');
    rainflow(:,:,1) = [Q1, Q2(:,2)];
    
    Y1 = xlsread(list{i}, 'Y1');
    Y2 = xlsread(list{i}, 'Y2');
    rainflow(:,:,2) = [Y1, Y2(:,2)];
    
    save([file, '.mat'], 'rainflow');
end 

cd(savepath);

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));