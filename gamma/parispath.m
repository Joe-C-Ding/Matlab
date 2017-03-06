function [ lifetime ] = parispath( ub, count )
%PARISPATH Summary of this function goes here
%   Detailed explanation goes here
clf;

C = 0.005;
n = 1.3;
beta = 1;
sigma = 1.7;
e = exp(1);

lifetime = [];
for i = 1:count
    x = 0.01;
    path = [x];
    while 1
        dx = e.^(sigma*randn(1)) * C * (beta * sqrt(x))^n;
        x = x + dx;
        path = [path dx];

        if x > ub
            lifetime = [lifetime size(path, 2)];
            break;
        end
    end
    plot(cumsum(path));
    hold on;
end

axis([0 max(lifetime) 0 ub]);
lifetime = sort(lifetime);
end

