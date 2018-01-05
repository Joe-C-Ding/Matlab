%������̬�ֲ����鷽��
clear all;
clf;
xdata1=xlsread('�����غ�.xls','Sheet1','G2:G125');
xdata=xdata1';
[f_ecdf, xc] = ecdf(xdata);
ecdfhist(f_ecdf, xc,12)
xlabel('���Ť��/(N.m)','FontSize',16);
ylabel('�����ܶȺ���p(x)','FontSize',16);
hold on;
x2=80:0.1:140;
[mu,sigma]=normfit(xdata);
[mu,sigma]
norm = normpdf(x2,mu,sigma);

hline3=plot(x2,norm,'b','linewidth',2);
cdfnorm=normcdf(x2,mu,sigma);
[h3, p3, k3, cv3]=kstest(xdata, 'cdf', [x2', cdfnorm']);
[h3, p3, k3, cv3]

%matlab �ضϷ���
A=80;
B=130;
x3=A:0.1:B;
pd = makedist('Normal', mu, sigma);
t = truncate(pd, A, B);
pdfnorm=normpdf(x3,t.mean,t.std);
cdfynorm=normcdf(x3,t.mean,t.std); 
[h4, p4, kstest4,cv4]=kstest(xdata, 'cdf',[x3', t.cdf(x3')]);
[h4, p4, kstest4,cv4]
hline4=plot(x3,t.pdf(x3),'g','linewidth',2);



%origin �ضϷ���

u=121.9313;  
c=5.28433;


%��ͬ�����������Ҫ����
xx=A:0.01:B;
y= @(xx) 2* exp(-(((xx-u)/c).^2)/2)/(( erf((B-u)/(sqrt(2)*c))-erf((A-u)/(sqrt(2)*c)))*c*sqrt(2*pi));
hline5=plot(xx,subs(y,xx),'r','linewidth',2);
d=0.01*cumsum(y(xx));
cdfynorm = @(x) interp1(xx,d,x,'Linear'); 
[h5, p5, kstest5,cv5]=kstest(xdata, 'cdf', [xdata1,cdfynorm(xdata1)]);
[h5, p5, kstest5,cv5]

%}
legend([hline3,hline4,hline5],'��̬�ֲ�','matlab��β','origin��β')
set(gca,'FontSize',14,'Fontname', 'Times New Roman');

%{ 
%�ۻ��ֲ�����
figure(2);
xlabel('���Ť��/(N.m)','FontSize',16);
ylabel('�ۻ�����p(x)','FontSize',16);
set(gca,'FontSize',14,'Fontname', 'Times New Roman');
hline5=plot(x2,cdf2,'k','linewidth',2);
hold on;

cdfyy=cdfy(x3)/apha2;
x4=401:1:501;
cdfyy(x4)=1;
hline6=plot(x2,cdfyy,'--r','linewidth',2);
legend([hline5,hline6],'���ܶ�','��β���ܶ�')
hold on
%}


%{

b1=[A b' B];
l=length(xdata);

figure(10)
d=0.01*cumsum(y(xx));
%d= integral(y(xx));
plot(d);
cdfy = @(x) interp1(xx,d,x,'Linear'); 
[h2, p2, kstest2,cv2]=kstest(xdata, 'cdf', [xdata1,cdfy(xdata1)])

%����ks���õ���ͨ�����߱Ƚϣ�֤��
[u,s]=normfit(xdata);
[h3,p3,kstest3,cv3]=kstest(xdata, 'cdf', [xdata1,normcdf(xdata1,u,s)])

x2=90:0.1:140;  %�ӽ�����95-135
[cdf2, x2] = ksdensity(F,x2, 'function', 'cdf');
[h1, p1, k1, cv1]=kstest(F, 'cdf', [x2', cdf2'])%
cdfy = @(x) interp1(x2,cdf2,x,'Linear');
apha2=cdfy(130);  %���߽ض�
[h2, p2, k2, cv2]=kstest(F, 'cdf', [x2', cdf2'/apha2])

figure(2);
h2=plot(x2,cdf2);
set(h2,'color','r','MarkerSize',15);


%{

p(1)=integral(y,A,b1(2));%����
for i=2:12;
    p(i)=integral(y, A, b1(i+1))-integral(y,A,b1(i)); %ע��100������
end;

for j=1:12;
     n(j)=sum(xdata>=b1(j)&xdata<b1(j+1));
end;

for j=2:12;
    e(j)=l*((n(j)/l-p(j))*(n(j)/l-p(j)))/p(j);
end;
s=sum(e);

z1=chi2inv(0.05,length(b)-1);
if s<z1
    display('����ԭ���裬˫��β��̬�ֲ�������㿨���Ŷ�')
else
    display('�ܾ�ԭ���裬˫��β��̬�ֲ���ϲ����㿨���Ŷ�')
end;
%}
%}

