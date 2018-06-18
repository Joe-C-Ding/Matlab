function [ U, V, para ] = psn_curve( N, S, dist, is_log, need_plot, verboss )
%PSN_CURVE [ U, V, para ] = psn_curve( N, S, dist, is_log, need_plot )
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

narginchk(3, 6);

if ~isvector(S) || size(N, 2) ~= length(S)
    error('psn_curve: size mismatch.');
end
S = reshape(S,1,[]);

if nargin < 4 || isempty(is_log)
    is_log = [true false];
elseif isscalar(is_log)
    is_log = [true is_log];
end

if nargin < 5 || isempty(need_plot)
    need_plot = false;
end

if nargin < 6 || isempty(verboss)
    verboss = false;
end

if is_log(1)
    n_handle = @reallog;
else
    n_handle = @(n) n;
end
if is_log(2)
    s_handle = @reallog;
else
    s_handle = @(s) s;
end

para = struct;
para.s_handle = s_handle;
para.n_handle = n_handle;

%% calc para
logN = sort(n_handle(N), 1);
logS = s_handle(S);
Necdf = ((1:size(N,1)).' - 0.3) ./ (size(N,1)+0.4);

us = mean(logN)';
s = logS.';
x0 = [s us ones(length(us),1)]\(us.*s);
x0 = [s us-x0(1) ones(length(us),1)]\(us.*s);
x0(3) = [];

    function l = loss(x)  
        v = bsxfun(@times, logN-x(1), logS-x(2));
        try
            if strcmpi(dist, 'wbl')
%                 [ shp, scl, loc ]  = wblpwm(v);
%                 pd = struct;
%                 pd.cdf = @(v) wblcdf(v-loc,scl,shp);
                pd = fitdist(v(:), 'Weibull');
            else
                pd = fitdist(v(:), dist);
            end
        catch ME
            warning(ME.message);
            l = inf; return;
        end

        l = bsxfun(@minus, Necdf, pd.cdf(v));
        l = norm(l(:), 2);
    end

% opt = optimset('MaxFunEvals', 5000, 'MaxIter', 5000);
[x,fval,exitflag,output] = fminsearch(@loss, x0);
if verboss
    disp(output);
end
if exitflag <= 0
    error('psn_curve: cannot solve parameters of U.');
end

[Necdf pd.cdf(v)]

%% make reture value
para.B = x(1); para.C = x(2);

V = struct;
V.ns = @(n, s)bsxfun(@times, para.n_handle(n)-para.B, para.s_handle(s)-para.C);
if is_log(2)
    V.nv = @(n, v) exp(para.C + v./(para.n_handle(n)-para.B));
else
    V.nv = @(n, v) para.C + v./(para.n_handle(n)-para.B);
end
if is_log(1)
	V.sv = @(s, v) exp(para.B + v./(para.s_handle(s)-para.C));
else
    V.sv = @(s, v) para.B + v./(para.s_handle(s)-para.C);
end

if strcmpi(dist, 'wbl')
    [ shp, scl, loc ]  = wblpwm(v(:));
    pdw = makedist('weibull', scl, shp);

    pd = struct;
    pd.loc = loc; pd.scl = scl; pd.shp = shp;
    
    pd.mean = pdw.mean - loc;
    pd.std = pdw.std;
    pd.var = pdw.var;
    
    pd.cdf = @(v) pdw.cdf(v-loc);
    pd.pdf = @(v) pdw.pdf(v-loc);
    pd.icdf = @(v) pdw.icdf(v) + loc;
    
    pd.random = @(varargin) pdw.random(varargin) + loc;
else
    pd = fitdist(v(:), dist);
end
para.pd = pd;

U = struct;
U.v = @(v) pd.cdf(v);
U.ns = @(n, s) U.v(V.ns(n, s));
U.sf = @(s, f) V.sv(s, pd.icdf(f));
U.nf = @(n, f) V.nv(n, pd.icdf(f));

U.randv = @(sample) pd.random(sample, 1);
U.rands = @(n, sample) V.nv(n*ones(sample, 1), U.randv(sample));
U.randn = @(s, sample) V.sv(s*ones(sample, 1), U.randv(sample));

%% plot
if need_plot
    figure;
    if strcmpi(dist, 'wbl')
        wblplot(v-loc);
    else
        probplot(dist, v);
    end
    
    figure;
    s = ones(size(N,1), 1) * S;
    plot(N, s, 'x');
    
    F = [0.1 0.5 0.9];
    N = linspace(0.9 * min(N(:)), 1.1 * max(N(:))).';
    s = zeros(length(N), length(F));
    for i = 1:length(F)
        s(:,i) = U.nf(N, F(i));
    end
    plot(N, s);

    if is_log(1)
        set(gca, 'xscale', 'log');
    end
end

end


