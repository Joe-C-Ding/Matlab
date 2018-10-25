start_tic = tic;
% close all but one figure, or creat one if none is there.
h = get(groot, 'Children');
if length(h) > 1
    i = ([h.Number] == 1);
    close(h(~i)); h = h(i);
end
clf(h);

RV = makedist('Normal', 100, 5);
F = @RV.cdf;
f = @RV.pdf;
Es = RV.mean;

N = @(s) 1e7
./s.^5;
lhs = integral(@(s) (1-F(s))./N(s), 0, inf);
rhs = Es * integral(@(s) f(s)./N(s), 0, inf);

[lhs, rhs, lhs-rhs]

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));