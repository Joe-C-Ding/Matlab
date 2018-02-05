start_tic = tic;
clf;

q = 1/1.1;
p = 1 - q;

n = 5;  % #. of cloths
a = ones(n, 1);

N = 3;  % times of wash
o = 1:n;    % order

for ii = 1:N
    for i = 1:n
        if i == 1
            a(o(i)) = p*a(o(i));
        else
            a(o(i)) = p*a(o(i)) + q*a(o(i-1));
        end
    end
%     o = o(randperm(n));   % change order for next wash
end

[min(a), mean(a), max(a), std(a)]


fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));