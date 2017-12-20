start_tic = tic;
clf;

x = (1:20).';
nx = length(x);

% 相邻多少元素取平均
nwin = 9;

% 把 x 折叠成想要的样子。
% spectrogram.m
ncol = nx - nwin + 1;
colindex = 0:(ncol-1);
rowindex = (1:nwin).';

xin = zeros(nwin, ncol, 'like', x);
xin(:) = x(bsxfun(@plus, colindex, rowindex)) % 没加分号，可以看看 xin 折叠成了什么样。

% 把头尾没算的元素插入回 y 里。
padding = fix(nwin/2) - 1;
y = [
    x(1:1+padding);
    mean(xin).';
    x(end-padding:end)
];

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));