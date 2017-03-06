function out = complete( in, miss )
%COMPLETE out = complete( in )
%   �˴���ʾ��ϸ˵��
if nargin < 2
    miss = isnan(in(:));
end

out = zeros(size(in));
out(~miss) = in(~miss);

out(miss) = interp1(find(~miss), in(~miss), find(miss));

end

