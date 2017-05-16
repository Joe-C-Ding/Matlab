function [ stress, times ] = getSpectrum(stress, times)
%GETSPECTRUM [ stress, times ] = getSpectrum(stress, times)
%   此处显示详细说明
narginchk(2, 2)

% 载荷谱定义
% 这里的数你可以自己改，调完了再去 dadN 里执行就能反映到结果里了。
spectrum = [
%   载荷,    级数
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

