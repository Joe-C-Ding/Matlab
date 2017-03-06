start_tic = tic;
% hold off;

A = 30;
N = 1e4;
t = linspace(0, 10, N);
t1 = t(1:floor(N/2));
t2 = t(floor(N/2)+1:end);
w = A/5 * t1;
w = [w, -A/5 * t2 + 2*A];
W = A/10 * t1 .^ 2;
W = [W, -A/10*(t2.^2 - 25) + 2*A*(t2-5) + 75];


y = sin(W);
% plot(t, y);
% h = hilbert(y);
a = angle(hilbert(y));
plot(t, W,t,unwrap(a));
wx = [0 diff(unwrap(a))./diff(t)];
wx(abs(wx) > 35) = 0;
plot(t, w, t,wx);


toc(start_tic);