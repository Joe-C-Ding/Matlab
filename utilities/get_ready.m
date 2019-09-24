function get_ready(keep)
%GET_READY start a tic, and close all figures but figure 1.
%   Detailed explanation goes here
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

