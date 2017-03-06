start_test = tic;
hold off

a = 2.95194377697143e-23;
b = 2.82775529449274;
l = 0.0676786238444302;

x = linspace(0.5e8, 1.9e8);
y = gammainc(l*30, a * (x .^ b), 'upper');
plot(x, y);

yq = [0.025 0.5 0.975];
xq = interp1(y, x, yq);
hold on
for i = 1:length(xq)
    plot([xq(i) xq(i)], [0 yq(i)], 'k--');
    plot([0.01e8 xq(i)], [yq(i) yq(i)], 'k--');
end

set(gca, 'XLim', [0.5e8 1.9e8]);
xlabel('????');
ylabel('????');

xq

toc(start_test);