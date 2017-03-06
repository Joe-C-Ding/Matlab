start_test = tic;
close;

I = 2;

files = {
    'AAAA071.mat'	%1
    'AAAA072.mat'	%2
    'AAAA074.mat'	%3
    'AAAA075.mat'	%4
    'AAAA076.mat'	%5
    'AAAA078.mat'	%6
    'AAAA080.mat'	%7
    'AAAA123.mat'	%8
    'AAAA126.mat'	%9
    'AAAA127.mat'	%10
    'AAAA128.mat'	%11
    'AAAA131.mat'	%12
};

M = length(files);

% construct the eqution with the form of 'F = EU'
F = [];     % in which, 'F' represents the loads (i.e. Q1 & Q2).
E = [];     % 'E' represents the signals on axle (i.e. channel A, B etc.).

for i = 1:M
    load(files{i}, 'WQ', 'WA');

    F = [F; WQ];
    E = [E; WA];
end

U_calc = (E\F)';
[b,bint,r,rint,stats] = regress(F(:,I), [ones(length(E), 1) E]);

res_calc = E * U_calc';
scatter(res_calc(:,I), r);

toc(start_test);
