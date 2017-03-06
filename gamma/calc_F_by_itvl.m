test_start = tic;
t = 3e8;

warnStruct = warning;
warning('off', 'MATLAB:integral2:maxFunEvalsFail');

% choose = 2;
% a = A(choose), b = B(choose), l = L(choose)

itvl = linspace(3, 15, 30);
F = zeros(length(itvl), 2);

for i = 1:length(itvl)
    interval = itvl(i);
    F(i, :) = Sn(t, @pond);
end
F = [itvl' F];

plot(F(:, 1), F(:, 2), 'x', F(:, 1), F(:, 3), 'o');

warning(warnStruct);
toc(test_start);