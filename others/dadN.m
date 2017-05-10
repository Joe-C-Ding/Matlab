start_tic = tic;
clf(gcf); ax = axes('parent', gcf);
hold(ax, 'on');
grid(ax, 'on');

% 步进取的越小算的越慢，相反精度越高。但精度太高对统计没什么意义。
% 比如我现在的参数设置（主要是F大了三倍），N 大约是 2.5 * 10^5 这个量级。
% 取 dN = 200, 精度大约就到了千分之一，统计上来说足够了。
B = 100;	% 要计算多少次N值
dN = 200;   % 步进
alpha = 0.05;   % 置信度，最后算 R 的时候用

% 这里算的 N 是载荷的循环次数，不是公里数。
% 一般按公里数算方便点，你得算一下平均一公里大约有多少个载荷循环。
% 下面那个 convert 是“一公里对应循环数”的倒数。
convert = 1;    % 循环次数 * convert -> 公里数
N = zeros(B, 1);

% 计算结果给你导出到 excel 里，方便你用其它软件做后续处理。
% 你可以改文件名，来把不同的计算结里存到不同的文件里做对比。
excel_name = 'result.xlsx';

%% 参数定义
ae = normrnd(0.173, 0.02065, B, 1);
af = normrnd(50, 5, B, 1);

kc = normrnd(3952, 48.67, B, 1);
kth = normrnd(172.56, 8.31, B, 1);

F = normrnd(287*3, 20, B, 1);   % 这里均值翻了三倍
K = normrnd(0.38, 0.0038, B, 1);
m = normrnd(1.5454, 0.05, B, 1);
C = 4.6957e-4;

%% 计算 N
for i = 1:B
    a = ae(i);
    n = 0;
    
    FKsqrtPI = F(i) * K(i) * sqrt(pi);
    if (FKsqrtPI*sqrt(a) <= kth(i))
        n = NaN;    % 不满足扩展判据
    else
        while(a < af(i))
            n = n + dN;
            
            dividend = 0.8 * (FKsqrtPI*sqrt(a) - kth(i));
            divisor = 0.8*kc(i) - FKsqrtPI*sqrt(a);
            if (divisor <= 0)    % 0.8*kc(i) <= FKsqrtPI*sqrt(a)
                break   % 失稳扩展
            end
            
            da = C * (dividend / divisor) ^ m(i);
            a = a + da*dN;
        end
    end
    N(i) = n;
end
N = sort(convert * N);

%% 画图
[R, Na, Rlo, Rup] = ecdf(ax, N, 'function','survivor', 'alpha',alpha);
ecdf(ax, N, 'function','survivor', 'alpha',alpha, 'bounds', 'on');
xlabel('N_{allow}');
ylabel('R');

%% 导出数据
xlswrite(excel_name, 'N', 1);
xlswrite(excel_name, N, 1, 'A2');
xlswrite(excel_name, {'N_allow', 'R_lower', 'R', 'R_upper'}, 2);
xlswrite(excel_name, [Na, Rlo, R, Rup], 2, 'A2');

%% 计算耗时
fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));