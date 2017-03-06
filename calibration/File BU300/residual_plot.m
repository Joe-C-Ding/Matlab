start_test = tic;

I = 2;

files = {
    'AAAA017rid.mat'	%1 'Left'
    'AAAA035rid.mat'	%2 'Left'
    'AAAA038rid.mat'	%3 'Left'
    'AAAA061rid.mat'	%4 'Left'
    'AAAA063rid.mat'	%5 'Left'
    'AAAA064rid.mat'	%6 'Left'
    'AAAA106rid.mat'	%7 'Left'
    'AAAA109rid.mat'	%8 'Left'
    'AAAA018rid.mat'	%9 'Right'
    'AAAA044rid.mat'	%10 'Right'
    'AAAA046rid.mat'	%11 'Right'
    'AAAA047rid.mat'	%12 'Right'
    'AAAA067rid.mat'	%13 'Right'
    'AAAA069rid.mat'	%14 'Right'
    'AAAA070rid.mat'	%15 'Right'
    'AAAA111rid.mat'	%16 'Right'
    'AAAA114rid.mat'	%17 'Right'
    'AAAA115rid.mat'	%18 'Right'
};


M = length(files);

% construct the eqution with the form of 'F = EU'
F = [];     % in which, 'F' represents the loads (i.e. Q1 & Q2).
E = [];     % 'E' represents the signals on axle (i.e. channel A, B etc.).

TimeAxis = [];  % used to plot figure.
TAend = 0;

for i = 1:M
    load(files{i}, 'WY', 'WW');

    F = [F; WY];
    E = [E; WW];
end

U_calc = (E\F)';
[b,bint,r,rint,stats] = regress(F(:,I), [ones(length(E), 1) E(:,[2*I-1 2*I])]);

res_calc = E * U_calc';
plot(res_calc(:,I), r, 'x');

toc(start_test);