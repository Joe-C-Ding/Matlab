get_ready(true)

%% up <-> R
% p = 0.01;
% us = 5000;
% ul = 5e4;
% ss = 200;
% sl = 0;
% 
% f = @(n) (us*n-ul) ./ hypot(ss*sqrt(n), sl) - norminv(1-p);
% fzero(f, 10)

%% series -- parallel
% ser = @(r) prod(r);
% par = @(r) 1 - prod(1-r);
% 
% r1 = par([0.9 0.9])

% r21 = ser([0.99 0.93])
% r22 = ser([0.98 0.97 0.99])
% r2 = par([r21 r22])

% r3 = 0.9
% 
% r = ser([r1 r2 r3])

%% 5 bubles
theta = 25000;
E = makedist('exp', theta);

x = E.random(1,5);
deviate = mean(x) - theta;
while abs(deviate) > 0.01 * theta
    x = E.random(1,5);
    deviate = mean(x) - theta;
end
x = sort(round(x - deviate));

fprintf('%d, ', x)
fprintf('\n');

%%
end_up(mfilename)