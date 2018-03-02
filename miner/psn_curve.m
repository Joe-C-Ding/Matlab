function [ U, W ] = psn_curve( s, N, is_logs )
%PSN_CURVE Summary of this function goes here
%   Detailed explanation goes here
if ~isvector(s) || size(N, 2) ~= length(s)
    error('psn_curve: bad input.');
end

if nargin < 3
    is_logs = true;
end

if is_logs
    s_handle = @reallog;
else
    s_handle = @(s) s;
end

logN = reallog(N);
logs = ones(size(N,1), 1) * s_handle(s(:).');

a = mean(logN(:,1:3))';
b = logs(1,1:3)';
x0 = [b ones(3,1) a]\(a.*b);
x0 = [b ones(3,1) a-x0(1)]\(a.*b);

opt = optimoptions('lsqcurvefit', 'Display', 'off');
[x,~,~,exitflag] = lsqcurvefit(@curve, x0, logs, logN, [], [], opt);
if exitflag <= 0
    error('psn_curve: cannot solve parameters of U.');
end

V = (logN-x(1)).*(logs-x(3));
[shp, scl, loc] = wblpwm(V);

U = @(n, s)(reallog(n)-x(1)).*(s_handle(s)-x(3)) - loc;
W = prob.WeibullDistribution(scl, shp);

end

function F = curve(x, logs)
    F = x(1) + x(2) ./ (logs-x(3));
end

