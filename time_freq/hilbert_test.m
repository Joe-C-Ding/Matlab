start_tic = tic;
% hold off;

load A1_speed.mat

sample_rate = 2000;
time = 1/sample_rate * (0:length(A1)-1)';

arg = angle(hilbert(A1));
% plot(time, A1);
% plot(time, unwrap(arg));
w = [0; diff(unwrap(arg))./diff(time)];
% wx(abs(wx) > 35) = 0;
plot(time, w);

toc(start_tic);