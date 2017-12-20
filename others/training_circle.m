start_tic = tic;
gcf; clf(1);
ax = axes('parent', 1);
hold(ax, 'on'); grid(ax, 'on');

m = 5000;   % #.of training
n = 1000;   % #.of testing

x = unifrnd(-2, 2, 2, m);
t = (x(1,:).^2 + x(2,:).^2 <= 1);
t = [t; ~t];

% theta = linspace(0, 2*pi);
% xx = cos(theta);
% yy = sin(theta);
% plot(ax, x(1,t), x(2,t), 'o',...
%      x(1,~t), x(2,~t), 'x', xx, yy, 'k--')

xtest = unifrnd(-2, 2, 2, n);
answer = (xtest(1,:).^2 + xtest(2,:).^2 <= 1);
answer = [answer; ~answer];

neuron = [3, 4, 5, 10, 50];
for i = neuron
    net = patternnet(i);
    
    a = tic;
    net = train(net, x, t);
    b = toc(a);
    
    y = net(xtest);
    error = confusion(answer, y);
    
    fprintf('error: %.2f%%;\t[%3d, %.4fs]\n', 100*error, i, b);
end

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));