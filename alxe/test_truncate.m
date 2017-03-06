function varargout = test_truncate( varargin )
%TEST_TRUNCATE ... = test_truncate(...)
%   �˴���ʾ��ϸ˵��
len = cellfun(@length, varargin);

plen = len <= 1;
varargout(plen) = varargin(plen);

len = min(len(len > 1));
for i = 1:length(varargin)
    if ~plen(i)
        varargout{i} = varargin{i}(1:len);
    end
end

end

