test_start = tic;
t = 3e8;

% choose = 2;
% a = A(choose), b = B(choose), l = L(choose)

itvl = linspace(1, 8, 30);
F = zeros(length(itvl), 2);

for i = 1:length(itvl)
    interval = itvl(i);
    F(i, :) = Sn(t, @pond);
end
F = [itvl' F];

plot(F(:, 1), F(:, 2), 'x', F(:, 1), F(:, 3), 'o');

warning(warnStruct);
toc(test_start);