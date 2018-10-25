start_tic = tic;
% close all but one figure, or creat one if none is there.
h = get(groot, 'Children');
if length(h) > 1
    i = ([h.Number] == 1);
    close(h(~i)); h = h(i);
end
clf(h);

%% prepare data
s = [525 500 475 450 400];
Nf = 10.^[
    4.8615	5.0237	5.2391	5.3522	5.7547
    5.0126	5.0846	5.2949	5.4595	5.8529
    5.1059	5.1427	5.3469	5.4929	5.9830
    5.1358	5.3079	5.3508	5.5013	5.9874
    5.1655	5.5103	5.4366	5.7822	6.0614
    5.3461	5.5403	5.6690	5.8874	6.2864
    5.5478	5.6652	5.8075	6.1497	6.2985
    5.6580	5.8491	5.8693	6.1679	6.4020
    5.6658	5.9033	5.9126	6.1715	6.4062
    5.7712	5.9253	5.9787	6.2305	6.4996
];
s = ones(size(Nf, 1), 1) * s;
gamma = mean(std(log(Nf))./ mean(log(Nf)));

b = -log(Nf(:));
A = [log(s(:)), -ones(numel(Nf), 1)];
x = A\b;
m = x(1);
C = exp(x(2));
% [m, log10(C), gamma]
clear A b;
clear x y s Nf

Ns = @(s) C./s.^m;

%%
s = [400 500];
n = [4e6 1.5e6];
lt = ["k", "k-."];

nn = 0;
dd = 0;
for i = [1 2]
    Nf = Ns(s(i));
    h = @(n) n/Nf;
    hinv = @(d) Nf*d;

    d_d0n = @(d0, n) h(bsxfun(@plus, hinv(d0), n));

    nx = linspace(0, n(i));
    dx = d_d0n(dd, nx);
    plot(nn+nx, dx, lt(i));
    
    dd = dx(end);
    nn = nn + nx(end);
end
h = text(n(1), dx(1), "$(n_1,d_1)$");
h.HorizontalAlignment = 'left';
h.VerticalAlignment = 'top';

nn = 0;
dd = 0;
for i = [2 1]
    Nf = Ns(s(i));
    h = @(n) n/Nf;
    hinv = @(d) Nf*d;

    d_d0n = @(d0, n) h(bsxfun(@plus, hinv(d0), n));

    nx = linspace(0, n(i));
    dx = d_d0n(dd, nx);
    plot(nn+nx, dx, lt(i));
    
    dd = dx(end);
    nn = nn + nx(end);
end
h = text(n(2), dx(1), "$(n_2,d'_2)$");
h.HorizontalAlignment = 'left';
h.VerticalAlignment = 'top';

xlim([0 1.1*nn]);
xticks([nn]);
xticklabels(["$n_1+n_2$"]);

ylim([0 1.1*dd]);
yticks([dd]);
yticklabels("$d$");

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));