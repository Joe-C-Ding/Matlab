function [ accrual ] = ret2accrual( annulized, inverse )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
narginchk(1, 2);
if nargin < 2
    inverse = false;
end

if ~inverse
    accrual = 1e4 * (annulized / 100) / 365;
else
    accrual = 100 * annulized * 365 / 1e4;
end

end

