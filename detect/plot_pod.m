start_tic = tic;
% close all but one figure, or creat one if none is there.
h = groot; h = h.Children;
if length(h) > 1
    i = ([h.Number] ~= 1);
    close(h(i)); h = h(~i);
end
clf(h); grid off;

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

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));