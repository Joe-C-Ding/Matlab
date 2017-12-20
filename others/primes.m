start_tic = tic;

N = 1e7;

% matlab vectors are 1-based, so odds(n) -> 2*n - 1
odds = true(1, ceil(N/2));
lodds = length(odds);

bound = sqrt(N);

for k = 3:2:bound
  if odds((k+1)/2)
     odds(((k*k+1)/2):k:lodds) = false;
  end
end

p = find(odds)*2 - 1;

p(1) = 2;
fprintf('%d\n', length(p))

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));