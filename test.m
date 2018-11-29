start_tic = tic;
% close all but one figure, or creat one if none is there.
h = get(groot, 'Children');
if length(h) > 1
    i = ([h.Number] == 1);
    close(h(~i)); h = h(i);
end
clf(h);

a = 2;
b = 5;
x = 10 + wblrnd(a,b, 100, 1);


para = [1, 3]; %[log(35), 1]; %[35, 1];
cdf = @wblcdf; %@logncdf; %@normcdf;
pdf = @wblpdf; %@lognpdf; %@normpdf;

cutoff = 10;
sc = linspace(10, 15);
fc = wblpdf(sc-cutoff, a,b);
Fc = wblcdf(sc-cutoff, a,b);
para = lsqcurvefit(@(para, x) pdf(x, para(1), para(2)), para, sc-10, fc)

plot(sc, fc, 'r', sc, pdf(sc-10, para(1), para(2)));
figure;
plot(sc, Fc, 'r', sc, cdf(sc-10, para(1), para(2)));

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));