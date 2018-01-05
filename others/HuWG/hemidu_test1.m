clear all;
F= xlsread('车钩载荷.xls','Sheet1','G2:G125');
F= F(F > 0);
% [h p stats]=chi2gof(F);
[f_ecdf, xc] = ecdf(F);
figure(1);
[n,c]=ecdfhist(f_ecdf, xc,26);

%[P_Z,F_Z]=ecdfhist(f_ecdf, xc,26);
hold on;
xlabel('纵向载荷');
ylabel('f(x)');

% 绘制核密度图
[f_ks1,xi1,u1] = ksdensity(F);
plot(xi1,f_ks1,'k','linewidth',1)

%求核密度截断曲线
delta=(xi1(length(xi1))-xi1(1))/(length(xi1)-1);
A=100; B=130; %截断区间为[A,B]
for i=2:length(xi1);
    if xi1(i-1)<A & xi1(i)>A  %插值寻找左截断点
        a1=xi1(i);
        b1=xi1(i+1);
        c1=f_ks1(i);
        d1=f_ks1(i+1);
        k1=(d1-c1)/(b1-a1);
        y1=c1+(A-a1)*k1;
        q=i;
    end
    if xi1(i)<B & xi1(i+1)>B   %插值寻找右截断点
        a2=xi1(i);
        b2=xi1(i+1);
        c2=f_ks1(i);
        d2=f_ks1(i+1);
        k2=(d2-c2)/(b2-a2);
        y2=c2+(B-a2)*k2;
        w=i;
    end
end

%修正截断核密度区间概率密度函数曲线
%截断区间[A,B]的概率
s1=delta*f_ks1(q:w); 
s1=sum(s1);
s2= y1*(xi1(q)-A)+ y2*(B-xi1(w));
s=s1+s2;

sum_qw =sum(f_ks1(q:w));
f_ks2=f_ks1(q:w)+f_ks1(q:w)*(1-s)/sum_qw/delta;
apdf=delta*sum(f_ks2)+s2;  %验证概率密度正确定，积分结果等于1
%方法2，不够准确
%plot(f_ks2);
%hold on
%f_ks3=f_ks1(q:w)+f_ks1(q:w)*(1-s)/s;
%plot(f_ks3,'r');

f_ks2=[y1,f_ks2,y2];
xxx=[A,xi1(q:w),B];
plot(xxx,f_ks2,'r','linewidth',1);
hold on
plot([A,A],[0,y1],'r','linewidth',1);
hold on
plot([B,B],[0,y2],'r','linewidth',1);
hold off

%求累积分布函数
leiji(1)=y1*(xi1(q)-A);%第一个点
for i=2:(length(xxx)-1);
  leiji(i)=delta*f_ks2(i)+leiji(i-1);  %中间等间距点
end
leiji(length(xxx))=leiji(length(xxx)-1)+ y2*(B-xi1(w)); %最后一个点
figure(2)
% plot(xxx,leiji,'r','linewidth',3);
x5=A:0.1:B;
y5=interp1(xxx,leiji,x5,'Linear'); 
plot(xxx,leiji,'.','color','r','MarkerSize',20);
hold on;
plot(x5,y5,'.','color','b','MarkerSize',10);
% hold off;
xlabel('x','fontsize',20);ylabel('y','fontsize',20);


%问丁然师兄这个为什么不行
cdf = @(x) interp1(xxx,leiji,x,'Linear'); 
N=[-inf c inf];
[h, p, st] = chi2gof(F, 'edges', N, 'cdf', cdf)
y=chi2inv(0.05,26-1);


%{
element=125.32;
[~,position]=min(abs(x5-element));
valuex5=x5(position);
valuey5=y5(position);
%}

