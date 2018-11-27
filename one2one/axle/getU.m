function U = getU(sb, Nb, Tg, k1, k2)
%GETU U = getU(sb, Nb, Tg, k1, k2)
%   Detailed explanation goes here

narginchk(3, 5);
if nargin < 4 || isempty(k1)
    k1 = 5;
end
if nargin < 5 || isempty(k2)
    k2 = 2*k1 - 2;  % Hibatch formula
end

mu = reallog(sb);
sg = reallog(Tg)/norminv(0.9)/2;

    function n = calc_n_by_sf(s, f, Nb, mu, sg, k1, k2)
        sp = exp(sg*norminv(f) + mu);
        n = bsxfun(@rdivide, sp, s);
        
        below = n>1;
        n( below) = Nb * n( below).^k2;
        n(~below) = Nb * n(~below).^k1;
    end

    function s = calc_s_by_nf(n, f, Nb, mu, sg, k1, k2)
        sp = exp(sg*norminv(f) + mu);
        s = Nb ./ n;
        
        below = s<1;
        s( below) = s( below).^(1/k2);
        s(~below) = s(~below).^(1/k1);
        s = bsxfun(@times, sp, s);
    end

U = struct;
U.sf = @(s, f) calc_n_by_sf(s, f, Nb, mu, sg, k1, k2);
U.nf = @(n, f) calc_s_by_nf(n, f, Nb, mu, sg, k1, k2);
U.s = @(s) logncdf(s, mu, sg);

end

