function [ U, V, para, stat ] = psn_curve( N, S, dist, is_log, need_plot, type, verboss )
%PSN_CURVE [ U, V, para ] = psn_curve( N, S, dist, is_log, need_plot, type, verboss )
%   type: 1 -> book method; 2 -> my_loss; 3 -> mle;
%   is_log: `slog' or [`nlog', `slog']
%
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

narginchk(3, 7);

if ~isvector(S) || size(N, 2) ~= length(S)
    error('psn_curve: size mismatch.');
end
S = reshape(S,1,[]);

if nargin < 3 || isempty(dist) || ~ischar(dist)
    dist = 'wbl';
end

if nargin < 4 || isempty(is_log)
    is_log = [true false];
elseif isscalar(is_log)
    is_log = [true is_log];
end

if nargin < 5 || isempty(need_plot)
    need_plot = false;
end

if nargin < 6 || isempty(type)
    type = 2;
end

if nargin < 7 || isempty(verboss)
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

persistent bad_cnt;
if isempty(bad_cnt)
    bad_cnt = 0;
end

%% calc para
logN = sort(n_handle(N),1);
logS = s_handle(S);

n = size(logN, 1);
Necdf = ((1:n).'-0.3) ./ (n+0.4);

us = mean(logN).';
s = logS.';
x0 = [s us ones(length(us),1)]\(us.*s);
x0 = [s us-x0(1) ones(length(us),1)]\(us.*s);
if type ~= 1
    x0(3) = [];
end

opt = optimset('MaxFunEvals', 8000, 'MaxIter', 8000);
loss = get_loss();
[x,fval,exitflag,output] = fminsearch(loss, x0, opt);
if verboss
    fval    %#ok
    output  %#ok
end
if exitflag <= 0
    error('psn_curve: cannot solve parameters of U.');
elseif output.iterations >= 200 || output.funcCount >= 200
    bad_cnt = bad_cnt + 1;
end


%% make reture value
stat = bad_cnt;
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

v = bsxfun(@times, logN-x(1), logS-x(2));
v = reshape(v, [], 1);

if strcmpi(dist, 'wbl')
    [ shp, scl, loc ]  = wblpwm(v);
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
    pd = fitdist(v, dist);
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

%%
function loss = get_loss()    
    switch type
        case 1
            loss = @book_loss;
        case 2    % norm(ecdf - cdf) for each `s'.
            loss = @my_loss;
        case 3    % mle
            loss = @mle_loss;
    end
end

%%
function loss = my_loss(x)
    v = bsxfun(@times, logN-x(1), logS-x(2));
    try
        if strcmpi(dist, 'wbl')
            [shp, scl, loc]  = wblpwm(v(:));
            pd = struct;
            pd.cdf = @(v) wblcdf(v-loc,scl,shp);
%             pd = fitdist(v(v>0), 'weibull');
        else
            pd = fitdist(v(:), dist);
        end
    catch ME
        warning(ME.message);
        loss = inf; return;
    end

    loss = bsxfun(@minus, Necdf, pd.cdf(v));
    loss = norm(loss(:));
end


function loss = book_loss(x)
    loss = bsxfun(@minus, logN-x(1), x(3)./(logS-x(2)));
    loss = norm(loss(:));
end


function loss = mle_loss(x)
    v = bsxfun(@times, logN-x(1), logS-x(2));
    try
        if strcmpi(dist, 'wbl')
            [shp, scl, loc]  = wblpwm(v(:));
            pd = struct;
            pd.negloglik = wbllike([scl shp], v(:)-loc);
        else
            pd = fitdist(v(:), dist);
        end
    catch ME
        warning(ME.message);
        loss = inf; return;
    end

    loss = pd.negloglik;
end

end


