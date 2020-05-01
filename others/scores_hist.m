get_ready()

scores = cell(1,3);
scores{1} = [
    68    66
    75    74
    70    70
    85    84
    80    80
    77    75
    72    72
    83    83
    85    84
    88    86
    63    63
    87    85
    90    90
    73    73
    82    82
    93    93
    77    75
    68    66
    94    93
    75    74
    70    70
    82    82
    75    74
    88    86
    80    80
    82    82
    83    83
    65    64
    83    83
    97    97
    74    73
    75    74
    81    81
    79    77
    76    75
    73    73
    83    83
    80    80
    90    90
    93    93
    91    91
    85    84
    98    98
    88    86
    89    87
    77    75
    86    85
    60    60
    90    90
    83    83
    75    74
    92    92
    92    92
    87    85
    95    95
    89    87
    80    80
    79    77
    98    98
    65    64
    91    91
    87    85
    88    86
    76    75
    88    86
    84    83
    84    83
    84    83
    82    82
    85    84
    82    82
    87    85
    80    80
    78    76
    84    83
    91    91
    77    75
    74    73
    70    70
];

scores{2} = [
    92,	    94
    80,     86
    95,     97
    82,     62
    73,     76
    63,     69
    81,     62
    93,     80
    85,     90
    62,     55
    86,     65
    81,     62
    79,     60
    90,     93
    91,     94
    90,     93
    92,     94
    88,     67
    86,     65
    60,     53
    93,     85
    88,     82
    95,     87
    81,     62
    73,     63
    73,     63
    82,     62
    88,     82
    78,     67
    80,     86
    86,     85
    93,     70
    77,     67
    90,     78
    88,     92
    93,     95
    88,     82
    74,     64
    84,     89
    85,     65
    73,     63
    83,     88
    87,     91
    90,     78
    88      77
];

scores{3} = [
    75,	    83
    73,     61
    81,     72
    70,     64
    77,     64
    74,     62
    77,     64
    80,     66
    82,     67
    75,     83
    92,     94
    94,     76
    64,     75
    74,     62
    76,     73
    88,     72
    92,     74
    87,     81
    74,     82
    88,     92
    77,     69
    88,     92
    55,     54
    65,     62
    75,     73
    67,     67
    73,     81
    75,     73
    70,     64
    73,     61
    92,     74
    83,     78
    78,     65
    60,     62
    83,     63
    83,     63
    82,     72
    79,     65
    85,     70
    63,     60
    68,     64
    73,     61
    76,     63
    80,     66
    82,     67
    86,     70
    85,     70
    80,     66
    87,     81
    85,     70
    79,     65
    90,     73
    40,     62
    55,     69
    55,     69
    68,     64
    63,     65
    90,     73
    77,     64
    77,     64
    84,     69
    70,     79
    80,     66
    78,     65
    78,     65
    84,     89
    76,     63
    67,     67
    72,     70
    73,     61
    90,     93
    92,     74
    88,     92
    93,     85
    82,     67
    70,     66
    95,     97
    84,     89
    80,     86
    89,     82
    72,     60
    88,     72
    79,     75
    79,     65
    80,     71
    80,     66
    85,     80
    81,     77
    65,     62
    76      83
];

k = 3;
str = {
    '上海局：共83人，缺考4人',
    '济南局（车辆工程）：共45人，缺考0人',
    '济南局（机械设计）：共96人，缺考6人',
};
e = 60:5:100;
fonts = 14;

subplot(2,2,[1 2]);
ax = gca;
h = textbox(ax, str{k}, 'N');
h.FontSize = fonts;
h.LineStyle = 'none';
ax.XAxis.Visible = 'off';
ax.YAxis.Visible = 'off';
ax.Color = 'none';

pos = [
    0.13         0.11      0.33466        0.7
    0.57034         0.11      0.33466        0.7
];

for i = 1:2
    subplot(2,2,i+2);
    ax = gca; hold(ax, 'on'); grid(ax, 'on');
    ax.Position = pos(i,:);
    
    histogram(ax, scores{k}(:,i), e);

    n = histcounts(scores{k}(:,i), [0 e]);
    N = size(scores{k}, 1);
    c = (e(2:end) + e(1:end-1))/2;
    p = 100 * n / N;

    d = strsplit(sprintf('%.0f%% ', p(2:end)));
    u = strsplit(sprintf('%.0f%% ', cumsum(p(1:end-1))));
    h1 = text(c, n(2:end), d(1:end-1));
    h2 = text(c, n(2:end), u(1:end-1));

    set(h1, 'HorizontalAlignment', 'center');
    set(h2, 'HorizontalAlignment', 'center');
    set(h1, {'VerticalAlignment', 'FontSize', 'Color'}, {'top', fonts, 'k'});
    set(h2, {'VerticalAlignment', 'FontSize', 'Color'}, {'bottom', fonts, 'b'});

    ax.XTick = e;
    if i == 1
        xlabel('考试成绩');
    else
        xlabel('总评成绩');
    end
    ax.YTick = 0:5:max(n);
    ylabel('人数');
    ylim([0 max(n)+2]);
    ax.FontSize = fonts;

    h = textbox(ax, {'\color{blue}\Sigman_i/N', '\color{black}n_i/N'}, 'NW');
    h.FontSize = fonts;
%     h.Interpreter = 'latex';
end

% st = [0 60:(40/6):100];
% st = [0:5:30];
% Y = discretize(0.3*scores{k}, st, st(2:end));
% [scores{k}' Y']

end_up(mfilename);