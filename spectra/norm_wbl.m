start_tic = tic;
figure(1);
clf; ax = gca;

hold(ax, 'on');
grid(ax, 'on');

if false
    N = [10000 1];

    u = 50;
    s = 15;
    xn = normrnd(u, s, N);

    c = 20;
    F = @(x)[x(1)*gamma(1+1/x(2)) - (u-c), x(1)^2*gamma(1+2/x(2)) - (u-c)^2 - s^2];
    x = fsolve(F, [u-c, 1]);

    a = x(1);
    b = x(2);
    [a b c]
    xw = wblrnd(a, b, N) + c;

    pdn = makedist('normal', u, s);
    pdw = makedist('weibull', a, b);

    xmin = min([xn; xw]);
    xmax = max([xn; xw]);
    x1 = linspace(-20, 120, 1e3);
    x2 = linspace(c, 120, 1e3);
    plot(ax, x1, pdn.pdf(x1), 'linewidth', 2);
    plot(ax, x2, pdw.pdf(x2-c), 'linewidth', 2);

    legend('Normal', 'Weibull');

    save('norm_weibul.mat', 'xn', 'xw', 'u', 's', 'a', 'b', 'c');
else
    load norm_weibul.mat
    
%     normplot([xn xw-20]);
    wblplot([xn xw-20]);
    legend('Normal', 'Weibull', 'location', 'SE');
end

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));