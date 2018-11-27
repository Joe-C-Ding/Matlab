start_tic = tic;
% close all but one figure, or creat one if none is there.
h = get(groot, 'Children');
if length(h) > 1
    i = ([h.Number] == 1);
    close(h(~i)); h = h(i);
end
clf(h);

%% prepar data.
% tested detial: 374km * 8 trip = 2992 km in total.
load spectrum.mat;
s = stress;
n = numbers(:,2);   % section B
plot(s, n);

N = sum(numbers);
r = km2rev(0.2992);
% max(abs(N-r))     %#<ok>, near 0 mean the total distance is correct.

ds = mean(diff(s));
N = sum(n);
p = n/N/ds;
% yyaxis right;
% plot(s, p);

ns = @(x) interp1(s, n, x, 'linear', 0);
ps = @(x) interp1(s, p, x, 'linear', 0);
% s_max = fzero(@(x) integral(ps, x, inf) - 5e-6, [30 80])

%% calc
sb = 180;
Nb = 1e7;
Tg = 1.4;

U = getU(sb, Nb, Tg);

% s_c = [144 160 180];
s_c = 180;
p = U.s(s_c);
[s_c.' p.']

Db = sum(n./U.sf(s, p)) ./ N;
1./Db

figure;
t = logspace(9, 13);
D = bsxfun(@times, t.', Db);
lt = ["k:", "k--", "k-."];
for i = 1:length(s_c)
    plot(t, D(:,i), lt(i));
end
% h = legendv(s_c, '%.0f', '\\sigma_b');
% h.Location = 'NorthWest';

h = gca;
h.XScale = 'log';
xlabel('$N$');
xticks(10.^[9 10 11 12 13]);

ylabel('$D$');
ylim([0 2]);

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));