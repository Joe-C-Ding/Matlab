start_tic = tic;
ax = cla('reset');

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

i = 1;
load(files{i});

f = mean(v2f(v));
s = floor(fsamp/4/f);
PP = P - WW(:,1);
P2 = [zeros(s,1); PP(1:end-s, 1)];
X = abs(PP)+abs(P2)+WW(:,1);


plot(ax, Time, FY(:,1)./X, Time, FY(:,1)./WW(:,1), 'r', Time, FY(:,1));
xlim([10 50]);

toc(start_tic);