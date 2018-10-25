function U = getU(sb, Nb, Tg)
%GETU U = getU(sb, Nb, Tg)
%   Detailed explanation goes here

mu = reallog(sb);
sg = reallog(Tg)/norminv(0.9)/2;

    function n = calc_n_by_sf(s, f, Nb, mu, sg)
        sp = exp(sg*norminv(f) + mu);
        n = bsxfun(@rdivide, sp, s);
        
        below = n>1;
        n( below) = Nb * n( below).^8;
        n(~below) = Nb * n(~below).^5;
    end

    function s = calc_s_by_nf(n, f, Nb, mu, sg)
        sp = exp(sg*norminv(f) + mu);
        s = Nb ./ n;
        
        below = s<1;
        s( below) = s( below).^(1/8);
        s(~below) = s(~below).^(1/5);
        s = bsxfun(@times, sp, s);
    end

U = struct;
U.sf = @(s, f) calc_n_by_sf(s, f, Nb, mu, sg);
U.nf = @(n, f) calc_s_by_nf(n, f, Nb, mu, sg);

end

