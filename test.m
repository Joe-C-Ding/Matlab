start_tic = tic;
% close all but one figure, or creat one if none is there.
h = groot; h = h.Children;
if length(h) > 1
    i = ([h.Number] ~= 1);
    close(h(i)); h = h(~i);
end
clf(h);

t = linspace(0,5);
F = @(x)expcdf(x, 10);

q = zeros(size(t));
funq = @(q,t) F(q) - 476/1430 - 954/1430 .* F((954*q-1100*t)/1430);
for i = 1:length(t)
    q(i) = fzero(@(q)funq(q,t(i)), [0, 15]);
end
plot(t, q);
legend('$q(t)$');

figure;
f1 = @(x, q) (143*x-30*q) .* exppdf(x, 10);
f2 = @(x, q) 113*q .* exppdf(x, 10);
P = @(q) integral(@(x)f1(x,q), 0, q) + integral(@(x)f2(x,q), q, inf);

Pi = zeros(size(t));
for i = 1:length(t)
    Pi(i) = P(q(i));
end
plot(t, Pi);
legend('$\Pi(t)$');

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));