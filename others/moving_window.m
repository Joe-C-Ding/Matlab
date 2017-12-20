start_tic = tic;
clf;

x = (1:20).';
nx = length(x);

% ���ڶ���Ԫ��ȡƽ��
nwin = 9;

% �� x �۵�����Ҫ�����ӡ�
% spectrogram.m
ncol = nx - nwin + 1;
colindex = 0:(ncol-1);
rowindex = (1:nwin).';

xin = zeros(nwin, ncol, 'like', x);
xin(:) = x(bsxfun(@plus, colindex, rowindex)) % û�ӷֺţ����Կ��� xin �۵�����ʲô����

% ��ͷβû���Ԫ�ز���� y �
padding = fix(nwin/2) - 1;
y = [
    x(1:1+padding);
    mean(xin).';
    x(end-padding:end)
];

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));