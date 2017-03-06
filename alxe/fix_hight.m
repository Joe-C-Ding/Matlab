if exist('log.txt', 'file')
    delete log.txt
end
% diary log.txt

start_tic = tic;
clf

load gps.mat

% [mu, sig] = normfit(hight)
p = (hight < 200);
hight2 = complete(hight, p);
hight2(~p) = nan;

% q = ~isnan(hight2);
% qq = q | [q(2:end); 0];
% qq = qq | [0; q(1:end-1)];
% 
% [hight(qq) hight2(qq) find(qq)]

plot(ts, hight); hold on;
plot(ts, hight2, 'r', 'linewidth', 2); grid on;
ylim([min(hight) max(hight)]);

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));
diary off
