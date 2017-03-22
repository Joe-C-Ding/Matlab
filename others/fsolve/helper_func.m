function [ rst ] = helper_func( x, S, N, s_b )
%FUNC 此处显示有关此函数的摘要
%   此处显示详细说明
if any(x < 0)
    rst = nan(2, 1);
else
    S = S(:);
    N = N(:);
    rst = S .* (1 + x(2)*N) .^ x(1) - s_b;
end

end

