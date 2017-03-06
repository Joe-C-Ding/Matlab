function [ lifetime observe ]= gammapath( ub, count, dt, t_obs )
%GAMMAPATH Summary of this function goes here
%   Detailed explanation goes here
clf;

if nargin < 3 || isempty(dt)
    dt = 0.01; 
end
if nargin < 4 || isempty(t_obs)
    t_obs = dt;
end

if isscalar(count)
    init_x = zeros(1, count);
else
    init_x = count;
    init_x(init_x < 0) = 0;
    count = size(count,1) * size(count,2);
end

lumbda = 1;
alpha = 1;
path_length = 1024;

lifetime = zeros(1, count);
observe = zeros(count, 2);


for i = 1:count
    needObserve = true;
    
    t = 0;
    x = init_x(i);
    path = zeros(2, path_length);
    j = 1;
    path(:,j) = [t x]';

    while 1
        j = j + 1;
        if j > path_length
            path = [path zeros(2, path_length)];
            path_length = 2*path_length;
        end
        
        t = t + dt;
        dx = gamrnd(alpha*dt, 1/lumbda, 1);
        
        x = x + dx;
        path(:,j) = [t x];
        
        if needObserve && t >= t_obs
            observe(i,1) = x;
            needObserve = false;
        end

        if x > ub
            lifetime(i) = t;
            if needObserve
                observe(i,:) = [ub t];
            else
                observe(i, 2) = t;
            end
            break;
        end
    end
    
    s = size(path(1, path(1,:)>0), 2);
    plot(path(1,1:s), path(2,1:s));
    hold on;
end

axis([0 max(lifetime) 0 ub]);

lifetime = sort(lifetime);
if nargout == 2
    observe = sortrows(observe, -1);
end

