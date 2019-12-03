function get_ready(keep)
% get_ready(keep = true) start a tic, and close all figures.
%   keep: if true, figure 1 will be kept from deleting.
if nargin < 1
    keep = true;
end

if keep
    h = get(groot, 'Children');
    if length(h) > 1
        i = ([h.Number] == 1);
        close(h(~i)); h = h(i);
    end
    clf(h);
    set(h, 'windowstyle', 'normal');
else
    close all;
end

global start_tic;
start_tic = tic;

end

