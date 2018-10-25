start_tic = tic;
close all;

x_str = 'mean(MPa)';
y_str = 'std.dev.';
font_size = 12;

%%
k = 3.5;
[sigma, mu] = meshgrid(0.5:0.1:3, 10:0.5:90);

f = @(s, m) integral(@(x) x.^k .* normpdf(x, m, s), m-3*s, m+3*s);
G = arrayfun(f, sigma, mu);

%%
figure;
mesh(mu, sigma, G);
xlim(mu([1 end]));
ylim(sigma([1 end]));
zlim([0 7e6]);

xticks(10:10:90);
yticks(0.5:0.5:3);
zticks(1e6*(0:7));

xlabel(x_str);
ylabel(y_str);
zlabel('G');

ax = gca;
ax.XAxis.FontSize = font_size;
ax.YAxis.FontSize = font_size;
ax.ZAxis.FontSize = font_size;

view(3);

%%
figure;
mesh(mu, sigma, G);
xlim(mu([1 end]));
ylim(sigma([1 end]));
zlim([0 7e6]);

xticks(10:10:90);
yticks(0.5:0.5:3);
zticks(1e6*(0:7));

xlabel(x_str);
ylabel(y_str);
zlabel('G');

ax = gca;
ax.XAxis.FontSize = font_size;
ax.YAxis.FontSize = font_size;
ax.ZAxis.FontSize = font_size;

view(0, 0);

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));