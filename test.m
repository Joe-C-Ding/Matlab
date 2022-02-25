get_ready()

%%
findpeaks
t = linspace(-2 * pi, 2 * pi, 1000);
phi = deg2rad(10);

s = sin(t + phi);
c = cos(t);

% plot(t, s, t, c);

space = (t(end) - t(1)) / length(t);
shift = floor(0.5 * pi / space);

[corr, lag] = xcorr(s, c(shift:end));
plot(lag, corr);

[corr, lag] = xcorr(s, c);
plot(lag+shift, corr, 'r');

%%
end_up(mfilename)