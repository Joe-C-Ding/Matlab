function t = taxle( signal, fs, tstart )
%TAXLE taxle( signal, fs, tstart )
%   �˴���ʾ��ϸ˵��

if nargin < 2 || ~isscalar(fs)
    fs = 2000;
end
if nargin < 3 || ~isscalar(tstart)
    tstart = 0;
end

t = tstart + (0:length(signal)-1)/fs;
if iscolumn(signal)
    t = cast(t, 'like', signal).';
else
    t = cast(t, 'like', signal);
end

end

