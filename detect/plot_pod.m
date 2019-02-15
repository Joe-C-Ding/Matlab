start_tic = tic;
close all

load POD;

pod = {"far","near","mag","elec"};
legs = {
    "Ultrasonic(far end)"
    "Ultrasonic(near end)"
    "Megnetic powder"
    "Eddy current"
};
line = {"k-.","k-","k:","k--"};

for i = 1:length(pod)
    varn = strcat('pod_', pod{i});
    eval(strcat('data = ', varn, ';'));
    
    plot(data(:,1), data(:,2), line{i});
end

xlabel('$a/{\rm mm}$');
ylabel('POD');
legend(legs, 'location','SE');

h = gca;
h.XTick = 0:2:20;
h.YTick = 0:0.2:1;
h.YLim = [0 1.1];

%%
fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));

figure(1);
if strncmpi(mfilename, 'plot_', 5)
    pname = mfilename;  % mfilename(6:end) wont work.
    print(pname(6:end), '-depsc');
else
    set(1, 'windowstyle', 'docked')
end