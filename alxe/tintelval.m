function [ index ] = tintelval( interval, fs, start )
%TINTELVAL [ index ] = tintelval( interval, fs, start )
%   此处显示详细说明
if nargin < 3
    start = 0;
end

interval = fs * (interval - start);
if interval(1) == 0, interval(1) = 1; end;
index = interval(1):interval(2);

end

