start_tic = tic;
clf

isplotGPS = false;

if ~exist('gps.mat', 'file')
    zip_GPS
    zip_Aspeed
    isplotGPS = true;
else
    load gps.mat
end

if isplotGPS
    plot(east, north);
    xlim([min(east), max(east)]);
    ylim([min(north), max(north)]);
    
    isplotGPS = false;
else
    unit = 110;
    mn = mean(north);
    Y = (north - min(north))* unit;
    X = (east - min(east))* unit * cos(mn * pi/180);
    
    ds = [0; sqrt(diff(X).^2 + diff(Y).^2)];
    plot(ts, cumsum(ds), 'r'); hold on;
%     plot(ts, cumtrapz(ts/3600, speed), 'r:')
    
    load Aspeed.mat

    fs = 60;
    winn = 2^nextpow2(2*fs);
    [~,~,tt,pc,fc] = spectrogram(A1, winn, winn*3/4, [], fs);
    pc(pc < 1) = 0;
    [~, I] = max(pc);

    [row, col] = size(pc);
    Hz2kph = pi*860/1000 * 3.6;
    kph = Hz2kph * fc(I + (0:col-1)*row);

    km = cumtrapz(tt/3600, kph);
    plot(tt, km); grid on;
end

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));