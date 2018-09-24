start_tic = tic;
% close all but one figure, or creat one if none is there.
h = groot; h = h.Children;
if length(h) > 1
    i = ([h.Number] ~= 1);
    close(h(i)); h = h(~i);
end
clf(h);

f = @(x) x+sin(x)-2.^x-2;
fplot(f, [-20 5]);

xlim([-20 5]);

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));