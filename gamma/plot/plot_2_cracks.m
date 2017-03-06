start_test = tic;
figure(1);
clf; ax = gca;

hold(ax, 'on');
ax.Box = 'on';

fonts = 14;

dataX{1} = [
           1                         5
      370609          5.10898013659804
      740609          5.22625628207986
     1110609          5.35278368946722
     1480609             5.48857544783
     1850722          5.63485567219492
     2221110          5.79221736134949
     2591110          5.96305858377331
     2961110           6.1477456666559
     3331225          6.34878686329879
     3701723          6.56753937949827
     4071723          6.80902458555879
     4441723          7.07811864280483
     4811723          7.38050709234431
     5182000          7.71979987997508
     5552000          8.10271142106726
     5922609           8.5380702064151
     6292609          9.03360212434111
     6662609          9.60089682458682
     7032609          10.2545791398584
     7402609          11.0099101777272
     7772722          11.8895355600649
     8143110          12.9170145021657
     8513110          14.1398382240629
     8883110          15.6105590004168
     9253225          17.3935997103548
     9623723          19.5759388191339
     9993723          22.2727149946328
    10363723          25.6283999527785
    10733723          29.8369658078316
    11104000          35.1978190423384
    11474000          42.0924679644624
    11844609          51.0866324017006
    12132609          60.0057191703856
];

dataX{2} = [
          1                         5
     370699          5.38956248115666
     740699          5.84321539530654
    1110699          6.37780166003372
    1480699          7.01510150537269
    1850699          7.78355511856857
    2221115          8.72061392190476
    2591115          9.87082933861694
    2961115          11.2914408884446
    3331407          13.0675444134346
    3701407          15.3028027612782
    4071407          18.1445948589588
    4441900          21.8237191275577
    4811900          26.6129937740059
    5181900          32.9266926993683
    5552000          41.3298839737875
    5922112          52.6532946684644
    6113900          60.0097968666189
];


h_c(1) = plot(ax, dataX{1}(:,1), dataX{1}(:,2), 'k');
h_c(2) = plot(ax, dataX{2}(:,1), dataX{2}(:,2), 'k--');
set(h_c, 'LineWidth', 2);

h_leg = legend({'$t_4 < t_f \le t$', '$t_3 < t_f'' \le t_4$'}, 'location', 'NW');
h_leg.Interpreter = 'latex';
h_leg.FontSize = fonts;

h_mark(1) = plot(ax, dataX{1}(end,1), dataX{1}(end,2), 'kx');
h_mark(2) = plot(ax, dataX{2}(end,1), dataX{2}(end,2), 'kx');
set(h_mark, 'MarkerSize', 10);
set(h_mark, 'LineWidth', 2);

h_txt = [];
h_txt(1) = text(ax, dataX{1}(end,1), dataX{1}(end,2)+3, '$t_f$');
h_txt(2) = text(ax, dataX{2}(end,1), dataX{2}(end,2)+3, '$t_f''$');

xlim = [1e5 4e7];
ylim = [0 70];

t = 2e7;
tn = logspace(log10(xlim(1)), log10(1.5*t), 6);
tn([1 end]) = [];

axis([xlim ylim]);
set(gca, 'XScale', 'log');
xlabel('time', 'Interpreter', 'latex')
ylabel('depth of crack ($a$)', 'Interpreter', 'latex')

set(gca, 'XTick', [tn t]);
set(gca, 'XTickLabel', {'$t_1$', '$t_2$', '$t_3$', '$t_4$', '$t$'});
set(gca, 'YTick', [5 60]);
set(gca, 'YTickLabel', {'$a_0$'; '$D_u$'});
ax.TickLabelInterpreter = 'latex';
ax.XMinorTick = 'off';
ax.FontSize = fonts;

h_line(1) = plot([t t], ylim, 'k:');       % t
h_line(2) = plot(xlim, [60 60], 'k:');     % D_u

for i = 1:length(tn)
    tt1 = interp1(dataX{1}(:,1), dataX{1}(:,2), tn(i), 'spline');
    tt2 = interp1(dataX{2}(:,1), dataX{2}(:,2), tn(i), 'spline');

    h_o(i) = plot([tn(i) tn(i)], [tt1 tt2], 'ko');
    
    switch i
    case {1, 2}
        h = text(1.1*tn(i), tt1+3, sprintf('$a_%d$', i));
        h_txt = [h_txt h];
    case 3
        h = text(1.15*tn(i), tt1+2, '$a_3$');
        h_txt = [h_txt h];
        h = text(1.15*tn(i), tt2+1, '$a_3''$');
        h_txt = [h_txt h];
    case 4
        h = text(1.1*tn(i), tt1+2, '$a_4$');
        h_txt = [h_txt h];
    end
    
    h_line(i+2) = plot([tn(i) tn(i)], ylim, 'k:');
end

set(h_line, 'LineWidth', 1.5);
set(h_txt, 'FontSize', fonts);
set(h_txt, 'Interpreter', 'latex');
set(h_o, 'MarkerSize', 7);
set(h_o, 'LineWidth', 1);

%% draw T
pos = ax.Position;
x = ax.XLim;
unit = pos(4) / log(x(2)/x(1));
x = pos(1) + log(tn(1:2) ./ x(1)) * unit;
y = pos([2 2]) + pos([4 4])./2;

h_arw = annotation('doublearrow', x, y);
h_arw.Head1Style = 'vback3';
h_arw.Head2Style = h_arw.Head1Style;

width = 0.05;
hight = 0.07;
dim = [mean(x)-width/2, mean(y)-hight/2, width, hight];
h = annotation('textbox',dim,'String','$T$');
h.Interpreter = 'latex';
h.BackgroundColor = 'w';
h.LineStyle = 'none';
h.HorizontalAlignment = 'center';
h.VerticalAlignment = 'cap';
h.FontSize = fonts;

toc(start_test);