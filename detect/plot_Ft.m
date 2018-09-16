start_tic = tic;
% close all but one figure, or creat one if none is there.
h = groot; h = h.Children;
if length(h) > 1
    i = ([h.Number] ~= 1);
    close(h(i)); h = h(~i);
end
clf(h); grid off;

load Ft_up_lo.mat

hl = plot(t, F(:,1), 'k--', t, F(:,2), 'k-.');
legend(hl, {'upper', 'lower'}, 'location', 'SE');

h = gca;
xlabel('$t$');
ylabel('$F(t)$');
h.YScale = 'log';
h.YLim = [1e-40 1];
h.YTick = 10.^[-40 -30 -20 -10 0];

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));