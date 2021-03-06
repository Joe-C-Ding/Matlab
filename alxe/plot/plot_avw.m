start_tic = tic;
clf

fs = 2000;
load A1_section.mat

xt = [8000 8001];

subplot(2,2,1);
plot(t, A1); grid on;
xlim(xt);
ylabel('A1 (ue)')

subplot(2,2,3);
plot(ts, speed); grid on;
xlim(xt);
ylim([195 198])
ylabel('speed (km/h)')
xlabel('t (s)')

F = fft(A1);
P = 2 * abs(F(1:length(t)/2) / length(t));
hz = fs*(0:length(t)/2-1)/length(t);

unit = find(hz >1, 1)-1;
[pks,locs] = findpeaks(cast(P, 'double'), 'MinPeakHeight', 0.32, 'MinPeakDistance', 5*unit);

size(pks)
[pks hz(locs)']

subplot(2,2,[2 4]);
plot(hz, P); hold on; grid on;
plot(hz(locs), pks, 'v');
xlim([0 100]);
xlabel('frequency (Hz)')
ylabel('Amplitude (ue)')

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));