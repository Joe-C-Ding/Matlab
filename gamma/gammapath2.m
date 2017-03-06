function [ lifetime ]= gammapath2( alpha, lumbda, b, u0, ub, count)
%GAMMAPATH2 [ lifetime ]= gammapath2( alpha, lumbda, b, u0, ub, count)
%   Detailed explanation goes here
tic;
% clf;
dt = 1e4; 

check = false;
path_length = 2e4;

lifetime = zeros(count, 1);

if check
    subplot(1,2,1);
end
for i = 1:count
    t = 0;
    a = u0;
    path = zeros(path_length, 2);
    insertp = 1;
    path(insertp, :) = [t a];

    while 1
        insertp = insertp + 1;
        if insertp > size(path, 1)
            path = [path; zeros(path_length, 2)];
        end
        
        da = gamrnd(alpha*((t+dt)^b - t^b), 1/lumbda, 1);
        t = t + dt;
        
        a = a + da;
        path(insertp, :) = [t a];
%         path(insertp, :)
        
        if a > ub
            lifetime(i) = t;
            dt = mean(lifetime(1:i)) / 1e4;
            break;
        end
    end
    
    length = find(path(:,2)==0, 1) - 1;
    plot(path(1:length,1), path(1:length,2));
    hold on;
end

axis([0 max(lifetime) u0 ub]);
% set(gca, 'XScale', 'log');
lifetime = sortrows(lifetime);

if check
    subplot(1,2,2);
    cdfplot(lifetime);
    hold on;

    x = linspace(lifetime(1), lifetime(end), 1e4);
    y = gammainc(lumbda*(ub-u0), alpha .* (x .^ b), 'upper');
    plot(x, y, 'm');
    legend('Empirical','Theoretical','Location','NW');
end

toc;
end

