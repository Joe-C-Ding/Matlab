start_tic = tic;
clf(gcf); ax = axes('parent', gcf);
hold(ax, 'on');
grid(ax, 'on');

% ����ȡ��ԽС���Խ�����෴����Խ�ߡ�������̫�߶�ͳ��ûʲô���塣
% ���������ڵĲ������ã���Ҫ��F������������N ��Լ�� 2.5 * 10^5 ���������
% ȡ dN = 200, ���ȴ�Լ�͵���ǧ��֮һ��ͳ������˵�㹻�ˡ�
B = 100;	% Ҫ������ٴ�Nֵ
dN = 200;   % ����
alpha = 0.05;   % ���Ŷȣ������ R ��ʱ����

% ������� N ���غɵ�ѭ�����������ǹ�������
% һ�㰴�������㷽��㣬�����һ��ƽ��һ�����Լ�ж��ٸ��غ�ѭ����
% �����Ǹ� convert �ǡ�һ�����Ӧѭ�������ĵ�����
convert = 1;    % ѭ������ * convert -> ������
N = zeros(B, 1);

% ���������㵼���� excel ��������������������������
% ����Ը��ļ��������Ѳ�ͬ�ļ������浽��ͬ���ļ������Աȡ�
excel_name = 'result.xlsx';

%% ��������
ae = normrnd(0.173, 0.02065, B, 1);
af = normrnd(50, 5, B, 1);

kc = normrnd(3952, 48.67, B, 1);
kth = normrnd(172.56, 8.31, B, 1);

F = normrnd(287*3, 20, B, 1);   % �����ֵ��������
K = normrnd(0.38, 0.0038, B, 1);
m = normrnd(1.5454, 0.05, B, 1);
C = 4.6957e-4;

%% ���� N
for i = 1:B
    a = ae(i);
    n = 0;
    
    FKsqrtPI = F(i) * K(i) * sqrt(pi);
    if (FKsqrtPI*sqrt(a) <= kth(i))
        n = NaN;    % ��������չ�о�
    else
        while(a < af(i))
            n = n + dN;
            
            dividend = 0.8 * (FKsqrtPI*sqrt(a) - kth(i));
            divisor = 0.8*kc(i) - FKsqrtPI*sqrt(a);
            if (divisor <= 0)    % 0.8*kc(i) <= FKsqrtPI*sqrt(a)
                break   % ʧ����չ
            end
            
            da = C * (dividend / divisor) ^ m(i);
            a = a + da*dN;
        end
    end
    N(i) = n;
end
N = sort(convert * N);

%% ��ͼ
[R, Na, Rlo, Rup] = ecdf(ax, N, 'function','survivor', 'alpha',alpha);
ecdf(ax, N, 'function','survivor', 'alpha',alpha, 'bounds', 'on');
xlabel('N_{allow}');
ylabel('R');

%% ��������
xlswrite(excel_name, 'N', 1);
xlswrite(excel_name, N, 1, 'A2');
xlswrite(excel_name, {'N_allow', 'R_lower', 'R', 'R_upper'}, 2);
xlswrite(excel_name, [Na, Rlo, R, Rup], 2, 'A2');

%% �����ʱ
fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));