function [U] = crack(a0, C, m, s1)
%CRACK [U] = crack(a0, C, m, s1)
%   fn_a0(n, a0) -> a
%   fa_a0(a, a0) -> n
%   pd_a0: a instance of prob. dist. of a0;

if ~isscalar(C) || ~isscalar(m) || ~isscalar(s1)
    error('fit_crack: C, m, s1 must be scalar!')
end
if any([C m s1] <= 0)
    error('fit_crack: C, m, s1 must be positive!')
end

C = C * (s1*sqrt(pi))^m;

if m == 2
    n2a_a0 = @(n,a0) bsxfun(@times, a0, exp(C.*n));
    a2n_a0 = @(a,a0) reallog(bsxfun(@rdivide, a, a0)) ./ C;
else
    n2a_a0 = @(n,a0) bsxfun(@minus, a0.^(1-m/2), C*(m-2)/2 * n).^(2/(2-m));
    a2n_a0 = @(a,a0) bsxfun(@minus, a0.^(1-m/2), a.^(1-m/2)) * 2/C/(m-2);
end

if ~isvector(a0) || isscalar(a0)
    error('fit_crack: bad a0!')
end
if length(a0) == 2
    k = -0.6;
    [mu, sgm] = calc(a0, k);
    pd_a0 = makedist('GeneralizedExtremeValue', 'k',k, 'sigma',sgm, 'mu',mu);
else
    pd_a0 = fitdist(a0, 'GeneralizedExtremeValue');
end

%% returns
U = struct;

U.n2a_a0 = n2a_a0;
U.a2n_a0 = a2n_a0;
U.pd_a0 = pd_a0;

U.pdn = @(a) pdn(a, U);
U.pda = @(n) pda(n, U);

end

function [mu, sgm] = calc(a, k)
    if numel(a) ~= 2
        error('crack>calc: internal error');
    end
    
    x = [1 gevinv(0.05, k,1,0)
         1 gevinv(   1, k,1,0)]\a(:);

    mu = x(1);
    sgm = x(2);
end

function pd = pdn(a, U)
    if ~isscalar(a)
        error('pda: bad a');
    end
    
    a0 = U.pd_a0.icdf([0.05, 1]);
    n = U.a2n_a0(a, a0);
    k = U.pd_a0.k;
    [mu, sgm] = calc(-n, k);
    pd_aux = makedist('GeneralizedExtremeValue', 'k',k, 'sigma',sgm, 'mu',mu);
    
    pd = struct;
    pd.b = -1/k;
    pd.a = pd.b * sgm;
    pd.l = -mu - pd.a;
    pd.pdf = @(n) pd_aux.pdf(-n);
    pd.cdf = @(n) 1 - pd_aux.cdf(-n);
    pd.icdf = @(p) -pd_aux.icdf(p);
    pd.mean = -pd_aux.mean;
    pd.std = pd_aux.std;
end

function pd = pda(n, U)
    if ~isscalar(n)
        error('pda: bad n');
    end
    
    a0 = U.pd_a0.icdf([0.05, 1]);
    a = U.n2a_a0(n, a0);
    k = U.pd_a0.k;
    [mu, sgm] = calc(a, k);
    pd = makedist('GeneralizedExtremeValue', 'k',k, 'sigma',sgm, 'mu',mu);
end

