function p = pond( a )
%POND �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

global POD
amin = POD(1,1); amax = POD(end, 1);

p = interp1(POD(:,1), 1-POD(:,2), a, 'nearest');
p(a <= amin) = 1 - POD(1, 2);
p(a >= amax) = 1 - POD(end, 2);

end

