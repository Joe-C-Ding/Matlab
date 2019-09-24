function [k, xihat, xici] = pickands_plot(x, alpha, freq, need_plot)
%PICKANDS_PLOT [xihat, xici] = pickands_plot(x, alpha=0.05, freq=1, need_plot=true)
%   Detailed explanation goes here
if nargin < 2 || isempty(alpha)
    alpha = 0.05;
end

if nargin < 3 || isempty(freq)
    freq = 1;
elseif ~isequal(size(freq), size(x))
    error('pickands_plot: freq size mismatch!');
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
    xk = x(k);
    x2k = x(2*k);
    x4k = x(4*k);
else
    freq = reshape(cumsum(freq(I)), [], 1);
    nx = freq(end);
    
    k = freq(freq < floor(nx/4));
    xk = x(freq < floor(nx/4));
    x2k = orderx(x, freq, 2*k);
    x4k = orderx(x, freq, 4*k);
    
    x2k(x2k == xk | x2k == x4k) = nan;
end

if length(k) < 4
    error("pickands_plot: too few elements in `x'")
end

xihat = log2((xk - x2k) ./ (x2k - x4k));

si = xihat.^2 .* (2.^(2*xihat+1) + 1) ./ (2 * log(2) * (2.^xihat-1)).^2;
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
    title('Pickands-plot');
end

end

function range = enlarge(x)
    si = diff(prctile(x, [5, 95]));
    range = [min(x)-si, max(x)+si];
end

function xk = orderx(x, cumfreq, k)
    xk = zeros(size(k));
    for i = 1:numel(k)
        xk(i) = x(find(cumfreq >= k(i), 1));
    end
end

