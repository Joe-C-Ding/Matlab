start_tic = tic;
clf;

sine_vol = 10;
q = sine_vol/(sine_vol+1);
p = 1 - q;

n = 10;  % #. of cloths
a = ones(n, 1);

N = 3;  % times of wash
o = 1:n;    % order
s = (n/(sine_vol+n))^N    % wash together

for ii = 1:N
    for i = 1:n
        if i == 1
            a(o(i)) = p*a(o(i));
        else%if a(o(i)) > a(o(i-1))
            a(o(i)) = p*a(o(i)) + q*a(o(i-1));
        end
    end
%     o = flip(o);
%     o = o(randperm(n));   % change order for next wash
%     [~, o] = sort(a, 'descend');
end

[min(a), mean(a), max(a), std(a)]
% res = [res a]

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));