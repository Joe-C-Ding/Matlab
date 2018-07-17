start_tic = tic;
% close all but one figure, or creat one if none is there.
h = get(groot, 'Children');
if length(h) > 1
    i = ([h.Number] == 1);
    close(h(~i)); h = h(i);
end
clf(h);

load data.mat
if true
    data = data_trans;
else
    data = data_orig;
end

x = []; dk = []; dadn = [];
for i = 1:length(data)
    x = [x; data{i}(:,1)];
    dk = [dk; data{i}(:,2)];
    dadn = [dadn; data{i}(:,3)];
end
dk = reallog(dk);
dadn = reallog(dadn);

bound = [
    0 2
    2 6
    6 20
];

x_plot = linspace(min(dk), max(dk));
c = 'rgb';
for i = 1:size(bound, 1)
    p = x >= bound(i,1) & x <= bound(i,2);
    plot(dk(p), dadn(p), ['x' c(i)]);
    
    b = polyfit(dk(p), dadn(p), 1)
    plot(x_plot, polyval(b, x_plot), ['--' c(i)]);
end

b = polyfit(dk, dadn, 1)
plot(x_plot, polyval(b, x_plot), 'k--');

xlim(x_plot([1 end]));
ylim([min(dadn), max(dadn)]);

h = gca;


fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));