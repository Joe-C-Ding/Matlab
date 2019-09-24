function [k, xihat, xici] = hill_plot(x, alpha, freq, need_plot)
%HILL_PLOT [xihat, xici] = hill_plot(x, alpha=0.05, freq=1, need_plot=true)
%   Detailed explanation goes here
if nargin < 2 || isempty(alpha)
    alpha = 0.05;
end

if nargin < 3 || isempty(freq)
    freq = 1;
elseif ~isequal(size(freq), size(x))
    error('hill_plot: freq size mismatch!');
else
    freq = ceil(freq);
    
    zerowgts = find(freq == 0);
    if numel(zerowgts) > 0
        x(zerowgts) = [];
        freq(zerowgts) = [];
    end
end

if nargin < 4 || isempty(need_plot)
    need_plot = true;
end

[x, I] = sort(x(:), 'descend');

if isscalar(freq)
    nx = length(x);
    
    k = (1:floor(nx/4)).';
    x = reallog(x(1:k(end)));
    
    xihat = x - x.';
    xihat(xihat < 0) = nan;
    xihat = nanmean(xihat).';
else
    freq = reshape(freq(I), [], 1);
    k = cumsum(freq);
    
    calcrange = k <= floor(k(end)/4);
    x = reallog(x(calcrange));
    k(~calcrange) = [];
    
    xihat = x - x.';
    xihat(xihat < 0) = nan;
    xihat = nansum(freq(calcrange).*xihat).' ./ k;
end

if length(k) < 4
    error("hill_plot: too few elements in `x'")
end

si = xihat.^2;
up = norminv(alpha/2)  ./ sqrt(k);
xici = [xihat + up.*si, xihat - up.*si];

if need_plot
    if isscalar(freq)
        plot(k, xihat, 'k');
    else
        plot(k, xihat, 'kx-');
    end
    plot(k, xici, 'k:');
    
    xlabel('$k$');
    ylabel('$\xi$');
    xlim(k([1 end]));
    ylim(enlarge(xihat))
    title('Hill-plot');
end

end

function range = enlarge(x)
    si = diff(prctile(x, [5, 95]));
    range = [min(x)-si, max(x)+si];
end

