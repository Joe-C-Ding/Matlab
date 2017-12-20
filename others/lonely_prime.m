start_tic = tic;

%% generate primes
N = intmax('uint32');
p = primes(N);	% 1x203280221 of 'uint32'
fprintf('prime generating elapsed: %f s\n', toc(start_tic));

%% calc dp (distance between primes)
dpt = [0 diff(p) intmax('uint32')];  % temp array
dp = min(dpt(1:end-1), dpt(2:end));

%% find lonely primes
lonely = zeros(50, 2, 'like', N);

dmax = dp(1);
ind = 1;
for i = 2:length(p)
    if dp(i) > dmax
        dmax = dp(i);
        lonely(ind,:) = [p(i) dp(i)];
        ind = ind + 1;
    end
end

%% print result
trunc = find(lonely(:,1) == 0, 1);
lonely(trunc:end, :) = []

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));