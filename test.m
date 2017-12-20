start_tic = tic;
clf;

digits(50);

f = exp(sqrt(sym(163))*sym(pi));
vpa(f)
double(f - round(f))

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));