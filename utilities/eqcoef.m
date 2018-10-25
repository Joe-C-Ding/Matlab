function [coef] = eqcoef(p, alpha, freq)
%EQCOEF [coef] = eqcoef(alpha, freq)
%   p = scalaror vector
%   alpha = @(p, s) -> a_ps
%   freq = n-by-2 vector of [loads; freqs]

narginchk(3, 3);

if ~isvector(p)
    error('eqcoef: p should be a scalar or a vector!');
end
need_trans = false;
if size(p, 1) ~= 1
    need_trans = true;
    p = p.';
end

if length(freq) >= 2
    if size(freq, 2) ~= 2
        error('eqcoef: freq should has size of n-by-2!');
    end
    n_total = sum(freq(:,2));
    if n_total ~= 1
        freq(:,2) = freq(:,2) / n_total;
    end
    
    coef = sum(bsxfun(@times, alpha(p, freq(:,1)), freq(:,2)));
    if need_trans
        coef = coef.';
    end

elseif isa(freq, 'function_handle')
    if isscalar(p)
        coef = integral(@(s) alpha(p, s).*freq(s), 0, inf);
    else
        coef = integral(@(s) alpha(p, s).*freq(s), 0, inf, 'ArrayValued',true);
        if need_trans
            coef = coef.';
        end
    end

else
    error('eqcoef: freq should be either vecotr or function!');
end

end

