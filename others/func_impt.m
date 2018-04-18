clear all;

need_import = true;
if need_import
    import_time = tic;
    a = linspace(0,1);
    b = gampdf(1,1,1);
    c = gamcdf(2,2,2);
    d = integral(@(x) x.^(1:10), 0, 1, 'arrayvalued', 1);
    e = gaminv(0.5,3,3);
    fprintf('import time: %f s\n', toc(import_time));
end

start_tic = tic;

% p1 =spstat.gamma(loc=-2, a= 7)
% p2 =spstat.gamma(loc=0, a= 20)

func = @(z, t)gampdf(t,20,1) * gamcdf(z+2-t,7,1);
Fz = @(z)integral(@(t)func(z, t), -inf, inf, 'arrayvalued', 1);


p = linspace(0, 1, 101).';
xp = gaminv(p,7,1)-2;
yp = gaminv(p,20,1);
Gp = Fz(xp+yp) - p;
% plot(p, Gp);

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));