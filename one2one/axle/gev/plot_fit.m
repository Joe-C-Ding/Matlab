start_tic = tic;
% close all but one figure, or creat one if none is there.
h = get(groot, 'Children');
if length(h) > 1
    i = ([h.Number] == 1);
    close(h(~i)); h = h(i);
end
clf(h);

load ../spectrum.mat

i = 2;
s = stress;
ds = s(2) - s(1);
n = numbers(:, i);
N = sum(n);

f = n/N/ds;
F = cumsum(n)/(N+1);

paras = {[7, 6], [35, 35], [log(35), 1], [35, 1]};
pdfs = {@wblpdf, @wblpdf, @lognpdf, @normpdf};
cdfs = {@wblcdf, @wblcdf, @logncdf, @normcdf};
icdfs = {@wblinv, @wblinv, @logninv, @norminv};

name = {"wbl3", "wbl2", "logn", "norm"};
cuts = [30, 0, 0, 0];
pcut = 1-1e-6;

for i = 1:length(paras)
    disp(name{i});
    
    para = paras{i};
    cdf = cdfs{i};
    pdf = pdfs{i};
    cut = cuts(i);
    
    sc = s(s>cut)-cut;
    fc = f(s>cut);
    Fc = F(s>cut);
    opts = optimoptions('lsqcurvefit','Display','off');
    [para,resnorm,residual,exitflag] = lsqcurvefit(...
        @(para, x) pdf(x, para(1), para(2)), para, sc, fc, [], [], opts);

    if exitflag < 0
        warning('bad solution!')
    end
    disp([para, resnorm, norm(residual, inf)]);
    
    sm = icdfs{i}(pcut, para(1), para(2)) + cut;
    disp(sm)

    if i == 3 %1
        plot(s, f, 'k', sc+cut, pdf(sc, para(1), para(2)), 'k-.');
        legend({"$\hat{f}(s)$", "$f(s)$"});
        xlim([30 45]);
        xlabel('stress/MPa');
        ylabel('pdf');
        
        figure;
        plot(s, F, 'k', sc+cut, cdf(sc, para(1), para(2)), 'k-.');
        legend({"$\hat{f}(s)$", "$f(s)$"}, 'location', 'se');
        xlim([30 45]);
        xlabel('stress/MPa');
        ylabel('cdf');
    end
end

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));