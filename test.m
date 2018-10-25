start_tic = tic;
% close all but one figure, or creat one if none is there.
h = get(groot, 'Children');
if length(h) > 1
    i = ([h.Number] == 1);
    close(h(~i)); h = h(i);
end
clf(h);

N = 10000;
x = sum(1./(1:N));
X = integral(@(x) 1./x, 1, N);

[x, X, x-X]

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));