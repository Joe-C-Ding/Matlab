start_tic = tic;

for j = 1:7
    figure(j);
    plot(stress, numbers(:,j), 'r');
end

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));