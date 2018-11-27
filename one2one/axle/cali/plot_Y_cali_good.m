start_tic = tic;
% close all but one figure, or creat one if none is there.
h = get(groot, 'Children');
if length(h) > 1
    i = ([h.Number] == 1);
    close(h(~i)); h = h(i);
end
clf(h);

i = 10;

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
load(files{i}, 'WY', 'WW', 'Time', 'fsamp');

if i < 9
    WY = WY(:, 1);
    WW = WW(:, 1:2);
else
    WY = WY(:, 2);
    WW = WW(:, 3:4);
end

U = (WW \ WY)';

YC = WY;
YS = WW * U';
E = YC - YS;
    
subplot(2,1,1);
plot(Time, YC, 'k-.', Time, YS, 'k');
legend({"$Y_{\rm ref}$", "$Y_{\rm calc}$"}, 'location', 's');

xlim(Time([1 end]));

ylabel('Load/kN');
ylim([0 25]);
% yticks(-20:10:20)

subplot(2,1,2);
RE = E ./ YC;
RE(abs(YC) < .5) = nan;
plot(Time, E, 'k');

xlabel('Time/s');
xlim(Time([1 end]));

ylabel('Error/kN');
ylim([-2 2])
yticks(-2:1:2);

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));