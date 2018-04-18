function [ U, V, para ] = psn_curve( s, N, is_log, need_plot )
%PSN_CURVE [ U, V, para ] = psn_curve( s, N, is_log, need_plot )
% returned result is:
%   U.v: @(v) statistic v -> F, ie cdf of v
%   U.ns = @(n, s) -> F
%   U.sf = @(s, f) -> n
%   U.nf = @(n, f) -> s
%
%   V.ns: @(n, s) -> V statistic
%   V.sv: @(s, v) -> n
%	V.nv: @(n, v) -> s
%
%   para: B, m, C; l, d, b; s_handle

narginchk(2, 4);

if ~isvector(s) || size(N, 2) ~= length(s)
    error('psn_curve: size mismatch.');
end

if nargin < 3 || isempty(is_log)
    is_log = [true true];
elseif isscalar(is_log)
    is_log = [true is_log];
end

if nargin < 4 || isempty(need_plot)
    need_plot = false;
end

if is_log(1)
    s_handle = @reallog;
else
    s_handle = @(s) s;
end
if is_log(2)
    n_handle = @reallog;
else
    n_handle = @(n) n;
end
para = struct;
para.s_handle = s_handle;
para.n_handle = n_handle;

%% calc para
logN = n_handle(N);
logs = ones(size(N,1), 1) * s_handle(s(:).');

a = mean(logN)';
b = logs(1,:)';
x0 = [b ones(length(a),1) a]\(a.*b);
x0 = [b ones(length(a),1) a-x0(1)]\(a.*b);

opt = optimoptions('lsqcurvefit', 'Display', 'off', 'MaxFunctionEvaluations', 5000);
[x,~,~,exitflag,output] = lsqcurvefit(@curve, x0, logs, logN, [], [], opt);
if exitflag <= 0
    error('psn_curve: cannot solve parameters of U.');
end

X = (logN-x(1)).*(logs-x(3));
[shp, scl, loc] = wblpwm(X);

%% make reture value
para.B = x(1); para.m = x(2); para.C = x(3);
para.l = loc; para.d = scl; para.b = shp;
disp(output);
fprintf(strcat(...
    'psn_curve: result B = %10.6g,    mu = %10.6g,    C = %10.6g\n',...
    '             lambda = %10.6g, delta = %10.6g, beta = %10.6g\n'), ...
    para.B, para.m, para.C, para.l, para.d, para.b);

V = struct;
V.ns = @(n, s)(para.n_handle(n)-para.B).*(para.s_handle(s)-para.C);
if is_log(1)
    V.nv = @(n, v) exp(para.C + v./(para.n_handle(n)-para.B));
else
    V.nv = @(n, v) para.C + v./(para.n_handle(n)-para.B);
end
if is_log(2)
	V.sv = @(s, v) exp(para.B + v./(para.s_handle(s)-para.C));
else
    V.sv = @(s, v) para.B + v./(para.s_handle(s)-para.C);
end

W = prob.WeibullDistribution(para.d, para.b);
U = struct;
U.v = @(v) W.cdf(v - para.l);
U.ns = @(n, s) U.v(V.ns(n, s));
U.sf = @(s, f) V.sv(s, para.l+W.icdf(f));
U.nf = @(n, f) V.nv(n, para.l+W.icdf(f));

%% plot
if need_plot
    figure;
    wblplot(X(:));
    
    figure;
    s = ones(size(N,1), 1) * s(:).';
    plot(N, s, 'x');
    
    F = [0.1 0.5 0.9];
    N = linspace(0.9 * min(N(:)), 1.1 * max(N(:))).';
    s = zeros(length(N), length(F));
    for i = 1:length(F)
        s(:,i) = U.nf(N, F(i));
    end
    plot(N, s);

    if is_log(2)
        set(gca, 'xscale', 'log');
    end
end

end

function F = curve(x, logs)
    F = x(1) + x(2) ./ (logs-x(3));
end

