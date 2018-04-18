function [ X ] = sn_rnd( s, n, para, dim )
%SN_RND [ X ] = sn_rnd( s, n, para, varargin )

narginchk(3, 4);
if ~isstruct(para)
    error('sn_rnd: 3rd argument should be a struct')
end

if nargin < 4 || isempty(dim)
    dim = 100;
end

if isempty(s)
    X = gen_stress(n, dim, para);
elseif isempty(n)
    X = gen_life(s, dim, para);
else
    X = gen_damage(s, n, dim, para);
end

end

function [row, col] = checksize(x, dim)
    if ~((isscalar(x) && isvector(dim)) || isvector(x) && isscalar(dim))
        error('sn_rnd: bad input')
    end
    
    if isscalar(x)
        if isscalar(dim)
            row = dim; col = 1;
        else
            row = dim(1); col = dim(2);
        end
    elseif isrow(x)
        row = dim; col = length(x);
    else
        row = length(x); col = dim;
    end
end

function S = gen_stress(n, dim, p)
    [row, col] = checksize(n, dim);
    
    W = wblrnd(p.d, p.b, row, col) + p.l;
    if p.s_handle(1) < eps  % log(1) == 0, means s_handle is @log()
        S = exp(bsxfun(@rdivide, W, log(n)-p.B) + p.C);
    else
        S = bsxfun(@rdivide, W, log(n)-p.B) + p.C;
    end
end

function N = gen_life(s, dim, p)
    [row, col] = checksize(s, dim);
    
    W = wblrnd(p.d, p.b, row, col) + p.l;
    N = exp(bsxfun(@rdivide, W, p.s_handle(s)-p.C) + p.B);
end

function D = gen_damage(s, n, dim, p)
    if ndims(s) ~= ndims(n) || any(size(s) ~= size(n))
        error('sn_rnd: size mismatch');
    end
    [row, col] = checksize(n, dim);
%     s = bsxfun(@times, s, ones(row, col));
    
    N = gen_life(s, dim, p);
    D = bsxfun(@rdivide, n, N);
end