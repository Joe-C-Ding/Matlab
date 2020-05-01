get_ready(false);

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

res = zeros(length(paras), 4);

c0 = floor(s(find(F>=0.001, 1)))
cuts = [c0, 0, 0, 0];
pcut = 1-1e-6;

for i = 1:length(paras)
%     disp(name{i});
    
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
    paras{i} = para;
    
    sm = icdfs{i}(pcut, para(1), para(2)) + cut;
    res(i, :) = [para(1), para(2), norm(residual).^2, sm];
end

%%
name = {"Weibull 3", "Weibull 2", "Log-Normal", "Normal"}
lty = {"k--", "k-.", "k--", "k-."};
disp(res);

group = {[1 2], [3, 4]};
for i = 1:length(group)
    figure;
    plot(s, f, 'k');
    for j = group{i}
        pdf = pdfs{j};
        plot(sc+cuts(j), pdf(sc, res(j,1), res(j,2)), lty{j});
    end
    legend({"data", name{group{i}}}, 'location', 'best');
    
    xlim([30 45]);
    xlabel('stress/MPa');
    ylabel('pdf'); 
    
    figure;
    plot(s, F, 'k');
    for j = group{i}
        cdf = cdfs{j};
        plot(sc+cuts(j), cdf(sc, res(j,1), res(j,2)), lty{j});
    end
    legend({"data", name{group{i}}}, 'location', 'se');
        
    xlim([30 45]);
    xlabel('stress/MPa');
    ylabel('cdf');
end

end_up(mfilename, ["wbl_pdf", "wbl_cdf", "norm_pdf", "norm_cdf"]);