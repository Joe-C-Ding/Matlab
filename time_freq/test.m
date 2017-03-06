start_tic = tic;
figure(1);
clf; ax = gca;

winlen = 16;
fs = 64;

npoints = 2^nextpow2(winlen*fs);
fs = npoints / winlen;

t = linspace(-winlen/2, winlen/2, npoints);
a = 3.1;
b = 3.2;
x = cos(2*pi*a*t); % + cos(2*pi*b*t);
r = 3*randn(1, npoints);

% figure
% plot(t, x);

y = fft(x);
Sxx = y .* conj(y);
Scc = abs(y).^2;

max(Sxx - Scc)

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));