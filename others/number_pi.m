% calc 1M places of pi, using vpa()
% finding some intersting numbers in it, or stat 0-9's cumulative mass.
start_tic = tic;
clf;

n = 1e6;
c = char(vpa(pi, n));

% strfind(c, '13717791320')
% strfind(c, '19890329')

cnt = zeros(1, 10);
for i = '0123456789'
    cnt(i-'0'+1) = length(c(c==i));
end

[0:9; cnt].'


fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));
