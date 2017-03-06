function [ V ] = compress( X, R )
%compress [ V ] = compress( X, R )
%   此处显示详细说明
if ~ismatrix(X)
    error('X is not a matrix')
end

%%
xl = length(X);

if R <= 1
    R = xl * R;
end
R = max(2, round(R));

%%
if R >= xl
    V = X;
    return;
end

p = round(1:(xl-1)/(R-1.0):xl);
if p(end) ~= xl
    p = [p xl];
end

[r c] = size(X);
if r >= c
    V = X(p, :);
else
    V = X(:, p);
end

end