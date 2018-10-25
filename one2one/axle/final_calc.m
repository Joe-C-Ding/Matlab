start_tic = tic;
% close all but one figure, or creat one if none is there.
h = get(groot, 'Children');
if length(h) > 1
    i = ([h.Number] == 1);
    close(h(~i)); h = h(i);
end
clf(h);

%% prepar data.
% tested detial: 374km * 8 trip = 2992 km in total.
if ~exist('numbers', 'var')
    load spectrum.mat;
end
s = stress;
n = numbers(:,4);   % section B
plot(s, n);

N = sum(numbers);
r = km2rev(0.2992);
max(abs(N-r))     %#<ok>, near 0 mean the total distance is correct.

ds = mean(diff(s));
N = sum(n);
p = n/N/ds;
% yyaxis right;
% plot(s, p);

ps = @(x) interp1(s, p, x, 'linear', 0);
fzero(@(x) integral(ps, x, inf) - 5e-6, [30 80])

%% calc
% sb = 180;
% Nb = 1e7;
% Tg = 1.4;
% 
% U = getU(sb, Nb, Tg);
% loads = ps;
% 
% h = @(n, p, s) bsxfun(@rdivide, n, U.sf(s, p));
% hinv = @(d, p, s) bsxfun(@times, d, U.sf(s, p));
% eta = @(d, n, p, s) h(hinv(d, p, s) + n, p, s);
% 
% s1 = 50;
% alpha = @(p, s) U.sf(s1, p) ./ U.sf(s, p);
% coef = @(p) eqcoef(p, alpha, loads);
% 
% dc = 1;
% t = logspace(9, 13);
% 
% r = zeros(size(t));
% for i = 1:length(t)
%     try
%         [f,fval,exitflag,output]  = fzero(@(p) eta(0, t(i)*coef(p), p, s1)-dc, [eps, 1-eps]);
% %         [f,fval,exitflag,output]  = fzero(@(p) eta(0, t(i)*coef(p), p, s1)-dc, [eps, 1-eps]);
%         if exitflag > 0
%             r(i) = 1 - f;
%             [i t(i) r(i)]
%         else
%             [f,fval,exitflag,output]
%             error('%s: error occurs', mfilename);
%         end
%     catch ME
%         d = eta(0, t(i)*coef([eps, 1-eps]), [eps, 1-eps], s1);
%         if (dc > nanmax(d))
%             r(i) = 1;
%         elseif (dc < nanmin(d))
%             r(i) = 0;
%         else
%             d
%             error('%s: error occurs', mfilename);
%         end
%     end
% end
% figure;
% plot(t, r);
% 
% xlabel('$N/{}$blocks');
% ylabel('$R$');
% h = gca;
% h.XScale = 'log';

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));