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

x = x + r;

win = gausswin(npoints, 4)';
x = x .* win;

X = fft(x);
P = 2 * abs(X(1:length(t)/2) / length(t));

hz = fs*(0:length(t)/2-1)/length(t);
plot(ax, hz, P);
ax.XLim = [0 6];

[m, i] = max(P);

%%
if false
    
str = {
    sprintf('WL = %.2f s', winlen),
    sprintf('FS = %.0f Hz', fs),
    sprintf('¦¤F = %.4f', hz(2)),
    '',
    sprintf(' %.2f Hz', a),
    sprintf(' %.2f Hz', b)
}
dim = [0.15 0.6 .3 .3];
figure(1);
annotation('textbox', dim, 'String', str,...
    'FitBoxToText', 'on', 'FontName', 'dialoginput');

end
%%
fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));