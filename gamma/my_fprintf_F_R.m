n = 4;
% bN = bN2;

life = bN(end, 1);
interval = 11; %km2r(life,1)/n;

fprintf('N = %d, life = %e (%f), itvl = %f:\n', n, life, km2r(life,1), interval);

F = 1;
path = @(x)interp1(bN(:,1), bN(:,2), km2r(x));
for i = 1:(n-1)
    p = path(i*interval);
    if isnan(p); break; end;
    
    fprintf('path: %.2f (%f)\n', p, pond(p));
    F = F * pond(p);
end

t = 5e8;
fprintf('R = 1-F = %.4f%%\n', 100*(1 - F));
fprintf('t = %.2e\n', t);
fprintf('R = 1-Sn = %.4f%%\n', 100 - 100*Sn(t, @pond)');