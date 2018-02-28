start_tic = tic;
clf;


X = prob.LognormalDistribution();
Y = prob.LognormalDistribution();
Z = prob.LognormalDistribution();

Lz = @(u, r, rs, Z)Z.cdf(Z.icdf(r) + rs.*(Z.icdf(r) - Z.icdf(u)));
Lxy =  @(u, r, rs, X, Y)Y.cdf(Y.icdf(r) + rs.*(X.icdf(r) - X.icdf(u)));

Sz = @(r, rs, Z)integral(@(u)Lz(u, r, rs, Z), 0, 1);
Sxy = @(r, rs, X, Y)integral(@(u)Lxy(u, r, rs, X, Y), 0, 1);

s1 = linspace(0.05, 1, 21);
s2 = linspace(0.05, 1, 21);
rs = linspace(0.05, 1, 21);

n = [length(s1), length(s2), length(rs)];
[n prod(n)]

R = zeros(n);
Rz = zeros(n(1:2));
for i = 1:n(1)
    X.sigma = s1(i);
    R(i, i:end, :) = nan;
    
    Z.sigma = s1(i);
    Rz(i, 1:i) = fzero(@(r)Sz(r, 1, Z)-r, [eps, 1-eps]);
    Rz(1:i, i) = Rz(i, 1:i);
    
    for j = 1:i-1
        Y.sigma = s2(j);
        
        for k = 1:n(3)
            R(i,j,k) = fzero(@(r)Sxy(r, rs(k), X, Y)-r, [eps, 1-eps]);
        end
    end
end

[R, I] = max(R, [], 3);
[X, Y] = meshgrid(s1, s2);
mesh(X, Y, R)
xlabel('$\sigma_1$');
ylabel('$\sigma_2$');

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));