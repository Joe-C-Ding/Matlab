start_tic = tic;
clf

load Aspeed.mat;
issub = false;

wl = [8 8 16].';
wlen = 2 .^ nextpow2(fs * wl);

winn = cell(length(wlen), 2);
winn{1, 1} = hann(wlen(1));     winn{1, 2} = ['hann ' num2str(wl(1))];
winn{2, 1} = gausswin(wlen(2)); winn{2, 2} = ['gaus ' num2str(wl(2))];
winn{3, 1} = gausswin(wlen(3), 4); winn{3, 2} = ['gaus ' num2str(wl(3))];

overlap = floor(15/16*wlen);

if issub
    subplot(2,1,1);
end
ax = gca;
hold(ax, 'on');
grid(ax, 'on');
for i = 1:length(wlen)
    [~,~,tt,pc,fc] = spectrogram(A1, winn{i,1}, overlap(i), [], fs);
    pc(pc < 1) = nan;
    fc(fc > 30) = nan;
    [~, I] = max(pc);

    [row, col] = size(pc);
    Hz2kph = pi*860/1000 * 3.6;
    kph = Hz2kph * fc(I + (0:col-1)*row);

    plot(ax, t(1) + tt, kph);
end
legend(winn{:,2});

if issub
    % xlim([7300 7600]);
    subplot(2,1,2);
    plot(t, A1)
    % xlim([7300 7600]);
end

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));