function [ U, V, para ] = psn_curve( s, N, is_logs, need_plot )
%PSN_CURVE [ U ] = psn_curve( s, N, is_logs, need_plot )
%   Detailed explanation goes here
narginchk(2, 4);

if ~isvector(s) || size(N, 2) ~= length(s)
    error('psn_curve: bad input.');
end

if nargin < 3 || isempty(is_logs)
    is_logs = true;
end

if nargin < 4 || isempty(need_plot)
    need_plot = false;
end

if is_logs
    s_handle = @reallog;
else
    s_handle = @(s) s;
end

logN = reallog(N);
logs = ones(size(N,1), 1) * s_handle(s(:).');

a = mean(logN)';
b = logs(1,:)';
x0 = [b ones(length(a),1) a]\(a.*b);
x0 = [b ones(length(a),1) a-x0(1)]\(a.*b);

opt = optimoptions('lsqcurvefit', 'Display', 'off', 'MaxFunctionEvaluations', 5000);
[x,~,~,exitflag] = lsqcurvefit(@curve, x0, logs, logN, [], [], opt);
if exitflag <= 0
    error('psn_curve: cannot solve parameters of U.');
end

X = (logN-x(1)).*(logs-x(3));
[shp, scl, loc] = wblpwm(X);

para = struct;
para.B = x(1); para.m = x(2); para.C = x(3);
para.l = loc; para.d = scl; para.b = shp;
fprintf(strcat(...
    'psn_curve: result B = %10.6f,    mu = %10.6f,    C = %10.6f\n',...
    '             lambda = %10.6f, delta = %10.6f, beta = %10.6f\n'), ...
    para.B, para.m, para.C, para.l, para.d, para.b);

V = struct;
V.ns = @(n, s)(reallog(n)-x(1)).*(s_handle(s)-x(3));
V.sv = @(s, v) exp(x(1) + v./(s_handle(s)-x(3)));
if is_logs
    V.nv = @(n, v) exp(x(3) + v./(reallog(n)-x(1)));
else
    V.nv = @(n, v) x(3) + v./(reallog(n)-x(1));
end

W = prob.WeibullDistribution(scl, shp);
U = struct;
U.v = @(v) W.cdf(v - loc);
U.ns = @(n, s) U.v(V(n, s));
U.sr = @(s, r) V.sv(s, loc+W.icdf(r));
U.nr = @(n, r) V.nv(n, loc+W.icdf(r));

if need_plot
    figure;
    wblplot(X(:));
    
    figure;
    s = ones(size(N,1), 1) * s(:).';
    plot(N, s, 'x');
    
    R = [0.1 0.5 0.9];
    N = logspace(log10(0.5 * min(N(:))), log10(2 * max(N(:)))).';
    s = zeros(length(N), length(R));
    for i = 1:length(R)
        s(:,i) = U.nr(N, R(i));
    end
    plot(N, s);
    set(gca, 'xscale', 'log');
end

end

function F = curve(x, logs)
    F = x(1) + x(2) ./ (logs-x(3));
end

