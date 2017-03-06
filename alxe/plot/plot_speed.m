start_tic = tic;
figure(1);
clf;ax = gca;

hold(ax, 'on');
grid(ax, 'on');

load ../Aspeed.mat;
issub = true;

wlen = 2 .^ nextpow2(fs * 16);
winn = gausswin(wlen, 4);
overlap = floor(15/16*wlen);

if issub
    subplot(2,1,2);
    ax = gca;
    hold(ax, 'on');
    grid(ax, 'on');
end

[~,~,tt,pc,fc] = spectrogram(A1, winn, overlap, [], 200);
pc(pc < 1) = nan;
fc(fc > 30) = nan;
[~, I] = max(pc);

[row, col] = size(pc);
Hz2kph = pi*860/1000 * 3.6;
kph = Hz2kph * fc(I + (0:col-1)*row);

plot(ax, t(1) + tt, kph, 'linewidth', 1.5);
plot(ax, t, speed, 'r', 'linewidth', 1.5);

xl = [1760 1830];
xlim(xl);
ylim([0 50]);
ylabel('speed (km/h)');
xlabel('time (s)')
ax.XTick = 1770:10:1830;
ax.YTick = 0:10:50;
legend({'calc''ed', 'GPS'}, 'location', 'NW');

if issub
    subplot(2,1,1);
    ax = gca;
    hold(ax, 'on');
    grid(ax, 'on');
    
    plot(ax, t, A1, 'linewidth', 1)
    xlim(xl);
    ylim([-130 130]);
    ax.YTick = -100:50:100;
    ylabel('A1 (ue)')
    ax.XTick = 1760:10:1830;
    ax.XTickLabel = {};
end

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));