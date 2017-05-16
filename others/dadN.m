start_tic = tic;
clf(gcf); ax = axes('parent', gcf);
hold(ax, 'on');
grid(ax, 'on');

% 两个文件配合执行的，一定要用 F5 或者点菜单栏的运行来执行。可别再选中几行那么玩了。
% 载荷谱的定义在 getSpectrum.m 里，那里的数你可以自己改。

%% 基本参数
B = 100;	% 要计算多少次N值
dN = 100;
dA = 0.01;
alpha = 0.01;   % 置信度，最后算 R 的时候用

N = zeros(B, 1);

% 计算结果给你导出到 excel 里，方便你用其它软件做后续处理。
% 你可以改文件名，来把不同的计算结里存到不同的文件里做对比。
excel_name = 'result.xlsx';


%% 模型参数
ae = normrnd(0.173, 0.02065, B, 1);
af = normrnd(50, 5, B, 1);

kc = normrnd(3952, 48.67, B, 1);
kth = normrnd(172.56, 8.31, B, 1);

% F = normrnd(287*3, 20, B, 1);   % 这里均值翻了三倍
K = normrnd(0.38, 0.0038, B, 1);
m = normrnd(1.5454, 0.05, B, 1);
C = 4.6957e-4;

%% 计算 N
% profile on;
for i = 1:B
    a = ae(i);
    n = 0;
    
    stress = -1;
    times = -1;
    while(a < af(i))
        [stress, times] = getSpectrum(stress, times);
        
%         [stress, times, n, a]
        FKsqrt = stress * K(i) * sqrt(pi * a);
        dividend = 0.8 * (FKsqrt - kth(i));
        divisor = 0.8*kc(i) - FKsqrt;
        if (dividend <= 0)  % 不满足扩展判据
            n = n + times;
            times = 0;
            continue;
        elseif (divisor <= 0)
            break   % 失稳扩展
        end

        da = C * (dividend / divisor) ^ m(i);
        dn = ceil(dA / da);
        if (dn > min(dN, times))
            dn = min(dN, times);
        end
        a = a + da * dn;
        n = n + dn;
        times = times - dn;
    end

    N(i) = n;
end
% profile viewer;

%% 画图
ecdf(ax, N, 'function','survivor', 'alpha',alpha, 'bounds', 'on');
xlabel('N_{allow}');
ylabel('R');
ax.XScale = 'log';
xlim([1e5 5e5])

%% 导出数据
% N = sort(N);
% xlswrite(excel_name, 'N', 1);
% xlswrite(excel_name, N, 1, 'A2');
% 
% [R, Na, Rlo, Rup] = ecdf(ax, N, 'function','survivor', 'alpha',alpha);
% xlswrite(excel_name, {'N_allow', 'R_lower', 'R', 'R_upper'}, 2);
% xlswrite(excel_name, [Na, Rlo, R, Rup], 2, 'A2');

%% 计算耗时
fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));