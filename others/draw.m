start_test = tic;

N = 100;
l = 5;
n = floor(N/2/l);


X = (1:(N-l+1))';
x = zeros(n, 1);

for i = 1:n
    r = randi(length(X), 1, 1);
    x(i) = X(r);
    
    I = r * ones(2*l-1,1);
    for j = 1:l-1 
        if r-j > 0 && X(r-j) == X(r)-j
            I(l-j) = r-j;
        end
        if r+j <= length(X) && X(r+j) == X(r)+j
            I(l+j) = r+j;
        end
    end
    
    X(I) = [];
end

X = (1:N)';
% Xcdf = unidcdf(1:N, N)';
% ecdf(x); hold on
% plot(X, Xcdf, 'r');
% legend('Empirical', 'Theoretical', 'Location', 'NW');
% 
% display('============= kstest =============');
% [h,p,ksstat,cv] = kstest(x, [X Xcdf])

xnew = zeros(n*l, 1);
for i = 0:l-1
    xnew(i*n+1:i*n+n) = x+i;
end

xnew = sort(xnew);
X(xnew) = [];

p = zeros(N, 1);
p(xnew) = 1;
plot(p);

toc(start_test);
