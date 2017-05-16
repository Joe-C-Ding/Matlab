start_tic = tic;
clf(gcf); ax = axes('parent', gcf);
hold(ax, 'on');
grid(ax, 'on');

% �����ļ����ִ�еģ�һ��Ҫ�� F5 ���ߵ�˵�����������ִ�С��ɱ���ѡ�м�����ô���ˡ�
% �غ��׵Ķ����� getSpectrum.m ��������������Լ��ġ�

%% ��������
B = 100;	% Ҫ������ٴ�Nֵ
dN = 100;
dA = 0.01;
alpha = 0.01;   % ���Ŷȣ������ R ��ʱ����

N = zeros(B, 1);

% ���������㵼���� excel ��������������������������
% ����Ը��ļ��������Ѳ�ͬ�ļ������浽��ͬ���ļ������Աȡ�
excel_name = 'result.xlsx';


%% ģ�Ͳ���
ae = normrnd(0.173, 0.02065, B, 1);
af = normrnd(50, 5, B, 1);

kc = normrnd(3952, 48.67, B, 1);
kth = normrnd(172.56, 8.31, B, 1);

% F = normrnd(287*3, 20, B, 1);   % �����ֵ��������
K = normrnd(0.38, 0.0038, B, 1);
m = normrnd(1.5454, 0.05, B, 1);
C = 4.6957e-4;

%% ���� N
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
        if (dividend <= 0)  % ��������չ�о�
            n = n + times;
            times = 0;
            continue;
        elseif (divisor <= 0)
            break   % ʧ����չ
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

%% ��ͼ
ecdf(ax, N, 'function','survivor', 'alpha',alpha, 'bounds', 'on');
xlabel('N_{allow}');
ylabel('R');
ax.XScale = 'log';
xlim([1e5 5e5])

%% ��������
% N = sort(N);
% xlswrite(excel_name, 'N', 1);
% xlswrite(excel_name, N, 1, 'A2');
% 
% [R, Na, Rlo, Rup] = ecdf(ax, N, 'function','survivor', 'alpha',alpha);
% xlswrite(excel_name, {'N_allow', 'R_lower', 'R', 'R_upper'}, 2);
% xlswrite(excel_name, [Na, Rlo, R, Rup], 2, 'A2');

%% �����ʱ
fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));