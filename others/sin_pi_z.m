start_tic = tic;
% close all but one figure, or creat one if none is there.
h = groot; h = h.Children;
if length(h) > 1
    i = ([h.Number] ~= 1);
    close(h(i)); h = h(~i);
end
clf(h);

% sin(pi*z)/pi = z * prod_{n=1}^inf (1 - z^2/n^2)
x = linspace(-pi, pi);
n = (1:1000).';

y = 1 - bsxfun(@rdivide, x.^2, n.^2);
y = x .* prod(y);
plot(x, y);

y2 = sin(pi*x)/pi;
plot(x, y2, 'r');

max(abs(y2-y))

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));