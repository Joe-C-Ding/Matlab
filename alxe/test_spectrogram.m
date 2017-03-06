start_tic = tic;
clf

isplotorig = false;
isplotspec = false;
isplotdist = false;

filename = 'Aspeed.mat';
if ~exist(filename, 'file')
    zip_Aspeed
else
    load(filename);
end

if isplotorig
    subplot(2,1,1)
    plot(t, A1);
    
    subplot(2,1,2)
    plot(t, speed);
else
    wlen = 2^nextpow2(4*fs);
    winn = hann(wlen);
    overlap = floor(0.6 * wlen);
    
    if isplotspec
        spectrogram(A1, winn, overlap, [], fs, 'yaxis');
    else
        [~,~,tt,pc,fc] = spectrogram(A1, winn, overlap, [], fs);
%         whos pc
        pc(pc < 1) = nan;
        fc(fc > 30) = nan;
        [~, I] = max(pc);

        [row, col] = size(pc);
        Hz2kph = pi*860/1000 * 3.6;
        kph = Hz2kph * fc(I + (0:col-1)*row);

        if isplotdist
            subplot(2,1,1)
        end
        plot(t(1) + tt, kph, 'b', 'linewidth', 2); grid on; hold on
        plot(t, speed, 'r')
        
        xlim([7900 9400]);

        if isplotdist
            subplot(2,1,2)
            km = cumtrapz(tt/3600, kph);
            plot(tt, km); grid on;
        end
    end
end

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));