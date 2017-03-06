start_test = tic;
hold off

load test.mat
% Ar2 = xlsread('Rainflow.xlsx', 2, 'A1:B512');

I = find(A(:,1) < 16);
A(I,:) = [];

As = sum(A(:,2));
Ars1 = sum(Ar1(:,2));
% Ars2 = sum(Ar2(:,2));

dA = mean(diff(A(:,1)));
dAr1 = mean(diff(Ar1(:,1)));

A(:,1) = A(:,1) * 0.206 * 2;
% A(:,2) = A(:,2) ./ As / dA;

% Ar1(:,2) = Ar1(:,2) ./ Ars1 / dAr1;
% Ar2(:,2) = Ar2(:,2) ./ Ars2;

N = 10;
for i = 1:length(A)
    ind = max(1,i-N/2):1:min(length(A), i+N/2);
    A(i,2) = sum(A(ind,2))/length(ind);
    Ar1(i,2) = sum(Ar1(ind,2))/length(ind);
%     Ar2(i,2) = sum(Ar2(ind,2))/length(ind);
end

f = @(x,A)(interp1(A(:,1), A(:,2), x));
SA = integral(@(x)f(x,A), A(1,1), A(end,1));
SAr1 = integral(@(x)f(x,Ar1), Ar1(1,1), Ar1(end,1));

A(:,2) = A(:,2) / SA;
Ar1(:,2) = Ar1(:,2) / SAr1;

EA = integral(@(x)(x .* f(x, A)), A(1,1), A(end,1))
DA = integral(@(x)((x.^2 .* f(x, A))), A(1,1), A(end,1));
DA = sqrt(DA - EA^2)

plot(A(:,1), A(:,2), 'r' ...
    , Ar1(:,1), Ar1(:,2), 'b' ...
    ..., Ar2(:,1), Ar2(:,2), 'k'...
    );

X = linspace(10, 70);
hold on;
% plot(X, normpdf(X, EA, 2.534), 'k--');

toc(start_test);