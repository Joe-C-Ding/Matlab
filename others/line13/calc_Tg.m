get_ready(false);
%%

Tg = [1.5];
lt = ["k:", "k--", "k-."];

k = 2 * norminv(0.9);
sg = log(Tg) ./ k;

f = linspace(0.001, 0.99).';
F = [0.001, 0.023, 0.1 0.5 0.9 0.99];

func = @(f)exp(norminv(f) .* log(Tg) / k);
q = func(f);
Q = func(F);

plot(norminv(f), q, 'k');

[F; Q]     %#ok<NOPTS>
plot(norminv(F), Q, 'k');
% legend({'$T_g=1.2$', '$T_g=1.3$', '$T_g=1.4$'}, 'location', 'NW');

h = gca;
h.YScale = 'log';
yt = [0.4:0.1:1, 1.5 2];
yticks(yt);
ylim(yt([1 end]));

xt = [0.001 0.01 0.05 0.1 0.5 0.9 0.95 0.99];
xticks(norminv(xt));
xticklabels(strsplit(num2str(xt, '%g\n')));
xlim(norminv([0.001 0.99]))

ylabel('$r=\sigma/\sigma_{0.5}$')
xlabel('failure, $F$/\%')

minor = [1, 2, 3, 5];
plot(norminv(F(minor)), Q(minor), 'ko');
for i = minor
    ht = text(norminv(F(i))+0.2, Q(i), sprintf('(%g, %.3f)', F(i), Q(i)));
    ht.HorizontalAlignment = 'left';
    ht.Color = 0.4 * [1, 1, 1];
end
ht.HorizontalAlignment = 'center';
ht.VerticalAlignment = 'bottom';
ht.Position = [ht.Position(1)-0.2, ht.Position(2)+0.1];

major = [4, 6];
plot(norminv(F(major)), Q(major), 'ro', 'MarkerFaceColor', [1, 0, 0]);
for i = major
    ht = text(norminv(F(i))+0.2, Q(i), sprintf('(%g, %.3f)', F(i), Q(i)));
    ht.HorizontalAlignment = 'left';
    ht.FontSize = 13;
end
ht.HorizontalAlignment = 'center';
ht.VerticalAlignment = 'bottom';
ht.Position = [ht.Position(1)-0.5, ht.Position(2)+0.1];

%%
end_up(mfilename);