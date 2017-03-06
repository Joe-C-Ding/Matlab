start_tic = tic;
figure(1);
clf; ax = gca;

hold(ax, 'on');
grid(ax, 'on');

m = 3.0;
c = 0.25e12;

% k = 5e6;
% c = (c / k)^((2*m-1) / m) * k;

x = 2 * [1.36, 4.08, 6.81, 9.53, 12.25, 14.98, 17.70, 20.42];
n = [662116000, 674188000, 16378000, 952400, 180800, 39600, 26000, 13200];

N = c ./ (x .^ m);
% N.'

sd = sum(n ./ N)
neq = 2e6;
xeq = (sd * c / neq)^(1/m)

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));