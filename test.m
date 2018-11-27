start_tic = tic;
% close all but one figure, or creat one if none is there.
h = get(groot, 'Children');
if length(h) > 1
    i = ([h.Number] == 1);
    close(h(~i)); h = h(i);
end
clf(h);

x = normrnd(100, 1);

u = linspace(min(x), max(x));


fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));