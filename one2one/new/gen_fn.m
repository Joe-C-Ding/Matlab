function [ fn ] = gen_fn( s, dists, treat_log )
%S2MV [ fn ] = gen_s2mv( s, dists, treat_log )
%   此处显示详细说明
narginchk(2, 3)
if nargin < 3
    treat_log = true;
end
if isempty(dists)
    fn = [];
    return
end

s = s(:);
m = arrayfun(@(x)x.mean(), dists);
v = arrayfun(@(x)x.var(), dists);
if treat_log
    s = log(s);
    m = log(m);
    v = log(v);
end
p1 = polyfit(s, m, 1);
p2 = polyfit(s, v, 1);

fn = @(s)gen(s, p1, p2, treat_log, dists(1).DistributionName);

end

function fn = gen(s, p1, p2, treat_log, dist)
s = s(:);
if treat_log
    m = exp(polyval(p1, log(s)));
    v = exp(polyval(p2, log(s)));
else
    m = polyval(p1, s);
    v = polyval(p2, s);
end

if dist == prob.LognormalDistribution.DistributionName
    mu = log(m.^2 ./ sqrt(v + m.^2));
    sigma = sqrt(log(v./m.^2 + 1));
    for i = length(s):-1:1
        fn(i) = makedist(dist, mu(i), sigma(i));
    end
% else
end

end
