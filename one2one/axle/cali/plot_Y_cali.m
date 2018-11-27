start_tic = tic;
% close all but one figure, or creat one if none is there.
h = get(groot, 'Children');
if length(h) > 1
    i = ([h.Number] == 1);
    close(h(~i)); h = h(i);
end
clf(h);

i = 17;

files = {
    'AAAA017rid.mat'	%1
    'AAAA018rid.mat'	%2
    'AAAA035rid.mat'	%3
    'AAAA038rid.mat'	%4
    'AAAA044rid.mat'	%5
    'AAAA046rid.mat'	%6
    'AAAA047rid.mat'	%7
    'AAAA061rid.mat'	%8
    'AAAA063rid.mat'	%9
    'AAAA064rid.mat'	%10
    'AAAA067rid.mat'	%11
    'AAAA069rid.mat'	%12
    'AAAA070rid.mat'	%13
    'AAAA106rid.mat'	%14
    'AAAA109rid.mat'	%15
    'AAAA111rid.mat'	%16
    'AAAA114rid.mat'	%17
    'AAAA115rid.mat'	%18
};

load(files{i}, 'WY', 'WW', 'Time', 'fsamp');

WY = WY(:, 2);
WW = WW(:, 3:4);

U = (WW \ WY)'

YC = WY;
YS = WW * U';
E = YC - YS;
    
subplot(2,1,1);
plot(Time, YC, 'k-.', Time, YS, 'k');
h = legend({"$Y_{\rm ref}$", "$Y_{\rm calc}$"});
h.FontSize = 12;

xlim(Time([1 end]));

ylabel('Load/kN');
ylim([-25 25]);
yticks(-20:10:20)

subplot(2,1,2);
RE = E ./ YC;
RE(abs(YC) < .5) = nan;
plot(Time, E, 'k');

xlabel('Time/s');
xlim(Time([1 end]));

ylabel('Error/kN');
ylim([-4.5 3])
yticks(-4:1:4);

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));