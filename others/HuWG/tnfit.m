function [ mu, sigma ] = tnfit( x, a, b )
%TNFIT [ mu, sigma ] = tnfit( x, a, b )
%   ���Լ�д�ľط����Ʋ�����Ч��Ӧ�ñȽϲ���ǲ��÷��飬���ÿ��������Աȡ�
narginchk(3, 3);

x = x(:);
m = [mean(x); var(x)];

f = @(x)func(x, a, b) - m;
para = fsolve(f, [m(1), sqrt(m(2))]);

mu = para(1); sigma = para(2);

end

function y = func(x, a, b)
    u = x(1); s = x(2);
    
    aa = (a-u)/s; bb = (b-u)/s;
    f = @normpdf; F = @normcdf;
    Z = F(bb) - F(aa); A = (f(aa)-f(bb))/Z;
    
    y = [u + s * A; ...
        s^2 * (1 + (aa*f(aa)-bb*f(bb))/Z - A^2)];
end