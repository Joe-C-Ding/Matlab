start_tic = tic;
clf;

s = 450;
n = 1e5;

h = 1 - para.B - para.l./(log(s)-para.C);
p = para.d ./ (log(s)-para.C);

A = @(n) (1-h-log(n))./p;
B = @(n) ((log(n)-para.B).*(log(s)-para.C) - para.l) ./ para.d;

F1 = @(x) 1-exp(-x.^para.b);
F2 = @(x) exp(-(-x).^para.b);

sample = 10;

N = sort(sn_rnd(s, [], para, sample));
F = U.ns(N, s);
R = F2(A(N));

d = flip(n ./ N);

% dmc = sn_rnd(s, n, para, sample);

% 
% histogram(dmc(end,:));
% figure;
% histogram(d(end,:));

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));