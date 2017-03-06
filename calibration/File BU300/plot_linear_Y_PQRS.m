close all
clear all
home

start_test = tic;

U = [
    -2.686726154670896   3.364596960245444  -0.018423174324946  -0.043461241546464
	 0.183195308682250   0.286275884183867   4.402696179886554  -0.524075333851218
];

files = {
    'AAAA017rid.dat', 'Left'	%1
    'AAAA018rid.dat', 'Right'	%2
    'AAAA035rid.dat', 'Left'	%3
    'AAAA038rid.dat', 'Left'	%4
    'AAAA044rid.dat', 'Right'	%5
    'AAAA046rid.dat', 'Right'	%6
    'AAAA047rid.dat', 'Right'	%7
    'AAAA061rid.dat', 'Left'	%8
    'AAAA063rid.dat', 'Left'	%9
    'AAAA064rid.dat', 'Left'	%10
    'AAAA067rid.dat', 'Right'	%11
    'AAAA069rid.dat', 'Right'	%12
    'AAAA070rid.dat', 'Right'	%13
    'AAAA106rid.dat', 'Left'	%14
    'AAAA109rid.dat', 'Left'	%15
    'AAAA111rid.dat', 'Right'	%16
    'AAAA114rid.dat', 'Right'	%17
    'AAAA115rid.dat', 'Right'	%18

};

i = 1;
[T Y W] = rdata(files{i,1}, files{i,2});

if strcmpi(files{i,2}, 'Left') == true
    c = 1; Yf = Y(:,1);
else
    c = 2; Yf = Y(:,2);
end;

Yr = Y(:,c);
Yc = W * U(c,:)';

subplot(2,2,[1 3])
plot(Yr, W(:,1), 'o', Yr, W(:,2), 'd');
hold on
plot(Yc, W(:,1), '--', Yc, W(:,2), '--');
legend('P', 'Q');

subplot(2,2,2)
plot(Yr, W(:,3), 'o'); 
hold on
plot(Yc, W(:,3), 'r--');
legend('R');

subplot(2,2,4)
plot(Yr, W(:,4), 'go');
hold on
plot(Yc, W(:,4), 'r--');
legend('S');


toc(start_test);