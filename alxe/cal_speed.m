start_tic = tic;
clf

is_plot = false;
is_checkpc = false;
is_showa1 = true;

load '2014-07-26 08-46-53_Channel_01_imcCronosSL_125767.mat'
A1 = val;
load '2014-07-26 08-46-53_Channel_33_imcCronosSL_125775.mat'
speed = val;

t = (0:length(speed)-1) ./ 1000;

N = 20;
fs = 2000 / N;
A1 = downsample(A1,N);

winn = 2^nextpow2(6*fs);
if is_plot
    spectrogram(A1, winn, winn/2, [], fs, 'yaxis');
%     ylim([0 30])
else
    [~,fff,tt,pc,fc] = spectrogram(A1, winn, winn/2, [], fs);

    pc(pc < 1) = 0;
    [~, I] = max(pc);
    
    [row, col] = size(pc);
    ff = fc(I + (0:col-1)*row);
    fff = fff(I');
    
    Hz2kph = pi*860/1000 * 3.6;
    Hz2kph * mean(diff(fc(:,1)))
    if is_showa1
        subplot(2,1,1);
        plot((0:length(A1)-1)./fs, A1); grid on
        subplot(2,1,2);
    end
    plot(t, speed, 'r', tt, fff * Hz2kph); grid on
end

if ~is_plot && is_checkpc
    t = 20 * 60;
    idx = find(tt > t, 1);
    plot(fs, pc(:, idx));
end

toc(start_tic);
