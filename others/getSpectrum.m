function [ stress, times ] = getSpectrum(stress, times)
%GETSPECTRUM [ stress, times ] = getSpectrum(stress, times)
%   �˴���ʾ��ϸ˵��
narginchk(2, 2)

% �غ��׶���
% �������������Լ��ģ���������ȥ dadN ��ִ�о��ܷ�ӳ��������ˡ�
spectrum = [
%   �غ�,    ����
    875,	223
    1014,	95
    1100,	59
    1250,	27
    1480,	9
    1480,	9
    1250,	27
    1100,	59
    1014,	95
    875,	223
];
level = length(spectrum);

if times > 0
    return;
end

persistent prs;
if isempty(prs) || stress < 0
    prs = 0;
end

prs = prs + 1;
if prs > level
    prs = 1;
end
stress = spectrum(prs, 1);
times = spectrum(prs, 2);

end

