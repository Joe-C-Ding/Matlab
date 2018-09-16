start_tic = tic;
% close all but one figure, or creat one if none is there.
h = groot; h = h.Children;
if length(h) > 1
    i = ([h.Number] ~= 1);
    close(h(i)); h = h(~i);
end
clf(h); grid off;

load cmp_berretta.mat

h_line = zeros(4,1);
h_line(1) = plot(berretta(:,1), berretta(:,2), 'k');
lt = {'k--', 'k:', 'k-.'};
for i = 1:3
    h_line(i+1) = plot(gamma(:,1,i), gamma(:,2,i), lt{i});
end

h = legend({'Berretta', 'Gamma1', 'Gamma2', 'Gamma3'});
h.Location = 'northwest';

h = gca;
xlabel('$N$');
ylabel('$a/$mm');

h.XLim = [2e5 2e7];
h.XScale = 'log';
h.YLim = [5 60];
h.YTick = [5 10:10:60];
h.XTick = [1e6 1e7];

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));