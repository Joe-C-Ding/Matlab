start_tic = tic;
clf;

if ~exist('multi_wbl.mat')
    X = prob.WeibullDistribution();

    S2 = @(r, rs, X)integral(@(u)L2(r, rs, X, u), 0, 1);
    S3 = @(r, rs, X)integral2(@(u,v)L2(r, rs, X, u,v), 0, 1, 0, 1, ...
        'RelTol', 1e-5);
    S4 = @(r, rs, X)integral3(@(u,v,w)L2(r, rs, X, u,v,w), 0,1, 0,1, 0,1, ...
        'RelTol', 1e-3);

    rs = [1 1 1];
    b = [0.5 1 2 3.5 10];

    opt = optimset(@fzero);
    opt.TolX = 1e-6;

    s2 = zeros(size(b));
    s3 = zeros(size(b));
    s4 = zeros(size(b));
    for i = 1:length(b);
        X.B = b(i);

        s2(i) = fzero(@(r)S2(r, rs, X)-r, [eps, 1-eps]);
        s3(i) = fzero(@(r)S3(r, rs, X)-r, [eps, 1-eps], opt);
        s4(i) = fzero(@(r)S4(r, rs, X)-r, [eps, 1-eps], opt);
    end
    [s2; s3; s4]
else
    load multi_wbl.mat
end

plot(b, s2, 'rx', b, s3, 'bo', b, s4, 'ks');
xlabel('$\beta$');
ylabel('$Rp$');

save('multi_wbl.mat', 'b', 'rs', 's2', 's3', 's4')


fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));