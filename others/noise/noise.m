start_tic = tic;
clf;

t = 2;
Hz = 4000;  % 2k - 5k should be very harmful

Fs = 8192;
x = linspace(0, t, t*Fs);
w = 2*pi*Hz;

y = sin(w*x);

sound(y, Fs);

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));
