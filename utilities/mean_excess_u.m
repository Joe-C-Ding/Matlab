function [eu, u] = mean_excess_u(cdf, u, freq)
%EU [u, eu] = mean_excess_u(cdf, u)
%   calc e(u) := E(x-u | x>u)
%   cdf: function of cdf, or [x cdf], or sample of x

narginchk(1, 3);

if isa(cdf, 'function_handle')
    if nargin < 2 || isempty(u)
        error('mean_excess_u: u must be given!');
    end

    eu = arrayfun(@(u)integral(@(x)1-cdf(x), u, inf) ./ (1-cdf(u)), u);

elseif isvector(cdf)
    if nargin < 3 || isempty(freq)      % x is sample
        x = sort(cdf(:));
        lenx = length(x);
        if nargin < 2 || isempty(u) || lenx >= 1e4
            u = x.';
        end

        if lenx < 1e4
            eu = bsxfun(@minus, x, u);
            eu(eu<=0) = nan;
            eu = nanmean(eu);
        else    % @bsxfun would involve too much memory.  
            sum = cumsum(x, 'reverse').';
            cnt = lenx:-1:1;
            eu = (sum - x' .* cnt) ./ (cnt - 1);
        end
    elseif size(freq) == size(cdf)
        zerowgts = find(freq == 0);
        if numel(zerowgts) > 0
            cdf(zerowgts) = [];
            freq(zerowgts) = [];
        end
        
        [x, I] = sort(cdf(:), 'descend');
        freq = reshape(freq(I), [], 1);
        cumfreq = cumsum(freq);
        cumfreq = harmmean([0, cumfreq(1:end-1).'; cumfreq.']);
        u = x.';
        
        eu = x - u;
        eu(eu <= 0) = nan;
        eu = nansum(freq.*eu) ./ cumfreq;
    else
        error('mean_excess_u: x and freq size mismatch!')
    end


elseif ismatrix(cdf) && nargin < 3   % [x cdf]
    u = cdf(:,1);
    F = cdf(:,2);

    used = 10;
    while true
        u0 = u(end-used);
        F0 = F(end-used);
        
        if (1-F0) > 1e-7
            break;
        else
            used = used + 5;
        end
    end
    uu = u(end-used:end);
    Fu = (F(end-used:end)-F0) / (1-F0);
    
    x0 = [-1, 10];
    lb = [-inf, 0];
    ub = [1, inf];
    ops = optimoptions('lsqcurvefit','Display','off');
    x = lsqcurvefit(@(x,u)gpcdf(u, x(1),x(2),u0), ...
                    x0, uu, Fu, lb, ub, ops);

    Fx = @(u)(1-F0)*gpcdf(u, x(1),x(2),u0) + F0;
    sm = integral(@(x)1-Fx(x), u(end), inf);

    Fc = 1-F;
    s = cumtrapz(cdf(:,1), Fc);
    eu = (s(end)-s+sm) ./ Fc;
    
else
    error('mean_excess_u: bad x!')
end

end