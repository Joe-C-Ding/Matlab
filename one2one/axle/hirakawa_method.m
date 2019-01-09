start_tic = tic;
close all

data = [180 67; 100 6.66e7; 0 1.33e8];

p = zeros(2, 2);
for i = 1:2
    ind = (i-1) + [1 2];
    p(:,i) = [data(ind, 1), [1 1].'] \ log10(data(ind, 2));
end

% Hs(s) is the spectrum
Hs = @(s) (s>=data(2,1)) .* 10.^polyval(p(:,1),s) ...
        + (s< data(2,1)) .* 10.^polyval(p(:,2),s);
H0 = Hs(0);

% ps(s) is pdf
Ps = @(s) log(0.1)/H0*Hs(s) .* ((s>=data(2,1)).*p(1,1) + (s<data(2,1)).*p(1,2));
% hs = @(s, ds) H0 * ds * Ps(s);

% Ns(s) is SN curve
bs = 145;
Ns = @(s) (s>=bs) .* 1e7.*(bs./s).^5 ...
        + (s< bs) .* 1e7.*(bs./s).^8;

Dt = H0 * integral(@(s) Ps(s)./Ns(s), 0, 180);


n_tot = integral(Hs, 100, 180);
Dh = H0/n_tot * integral(@(s) Hs(s)./Ns(s), 100, 180);

% ds = 5;
ds = [10 5 1 0.01]; % step
D = zeros(size(ds));

if isscalar(ds)
    np = true;
else
    np = false;
end
for i = 1:length(ds)
    edgs = 100:ds(i):180;
    N = Hs(edgs(1:end-1));
    n = [-diff(N) 0];
    
    D(i) = nansum(n./Ns(edgs(1:end-1)));
    
    if np
        figure;
        s = linspace(0, 180);
        bar(edgs(2:end), N, 1);
        plot(s, Hs(s));
        set(gca, 'yscale', 'log');
        
        figure;
        bar(edgs(1:end-1), n, 1);
        set(gca, 'yscale', 'log');
        
        figure;
        plot(s, Ps(s));
        
        figure;
        s = linspace(100, 300);
        plot(Ns(s), s);
        set(gca, 'yscale', 'log', 'xscale', 'log');
    end
end
[D Dt Dh]
% plot([ds 0], [D Dt], 'x');

%%
fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));

figure(1);
if strncmpi(mfilename, 'plot_', 5)
    pname = mfilename;  % mfilename(6:end) wont work.
    print(pname(6:end), '-depsc');
else
    set(1, 'windowstyle', 'docked')
end