start_tic = tic;
close all;

list = dir('rainflow/rainflow/*.mat');
list = {list.name}';

sum = zeros(256, 3, 2);

for i = 1:length(list)
    load(['rainflow/rainflow/', list{i}]);
    
    sum = sum + rainflow;
end
sum(:,1,:) = sum(:,1,:) / i;
p = (sum < 5);
p(:,1,:) = 0;
sum(p) = 0;

L = {{'Q1', 'Q2'}, {'Y1', 'Y2'}};
for i = 1:2
    figure;
    h = plot(sum(:,1,i), sum(:,2,i), sum(:,1,i), sum(:,2,i));
    legend(L{i});
end

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));