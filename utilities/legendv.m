function [handle] = legendv(vector, format, v_name)
%LEGENDV legendv(vector, format, v_name)
%   format: format string, that is sth like `%.2f'.
%   v_name: varable's name. say it is 'v', then the legend will be 'v = v1, ...'

narginchk(1, 3)
if nargin < 3 || isempty(v_name)
    v_name = '';
end
if nargin < 2 || isempty(format)
    format = '%.2f';
end

if isempty(v_name)
    format = strcat(format, '\n');
else
    format = strcat('$',v_name,'=',format,'$\n');
end

target = strsplit(num2str(vector, format));
handle = legend(target);

end

