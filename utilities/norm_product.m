function [ mu, sigma ] = norm_product( M, V )
%NORM_PRODUCT �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

M = M(:);
n = length(M);
V = V(1:n);

func = @(ux, uy, sx, sy)sqrt(ux^2*sy^2 + sx^2*uy^2 + sx^2*sy^2);

mu = M(1);
sigma = V(1);
for i = 1:n-1
    sigma = func(mu, M(i+1), sigma, V(i+1));
    mu = mu * M(i+1);
end

end

