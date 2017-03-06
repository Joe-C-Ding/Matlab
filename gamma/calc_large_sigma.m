Theta = [
    6.46017892342081e-19       2.63442078342551          49.7013328962502
    4.4369890460046e-18        2.4666170988831           14.8588377172234
    5.47247315026415e-20       2.71493814479195          18.9437368347109
    5.59046227096689e-21       2.78724439321858           7.4692936907018
    1.69665945283884e-21       2.82775529449274          4.83116395817372
];

i = 5;
a = Theta(i, 1);
b = Theta(i, 2);
l = Theta(i, 3);

% t = linspace(1.4e8, 1.8e8);
% % cl = 'rmygcbk';
% 
clf;
% 
% for i = 1:size(Theta, 1)
%     a = Theta(i, 1);
%     b = Theta(i, 2);
%     l = Theta(i, 3);
% 
%     subplot(1,2,1);
% 	hold on; plot(t, Ft(t));
%     subplot(1,2,2);
%     hold on; plot(t(2:end), diff(Ft(t)));
% end

ra = 1/sqrt(30*l);
rb = 30*l;

mu = rb*(1+ra^2/2);
sg = ra*rb*sqrt(1+1.25*ra^2);
tao = sg^2 - mu

c = norminv(0.9, 0, 1);
M(i,:) = [mu - c*sg mu mu + c*sg];
T(i,:) = (M(i,:)./a).^(1/b)
Tx = [T(i,:); T(i,:)]; Ty = [0 0 0; 1 1 1];

x = linspace(1e7, 2.5e8, 1e3);
y1 = gammainc(l*30, a * (x .^ b), 'upper');
plot(x, y1, 'r');

hold on; grid on;
% plot(Tx(:,1), Ty(:,1),Tx(:,2), Ty(:,2),Tx(:,3), Ty(:,3));

tu = (mu/a)^(1/b)
K1 = tu^b;
K2 = (1.5*tu)^b;

syms X Y
s = solve(X == K1*Y, X + 3*sqrt(X + 0.75) == K2*Y, X, Y);
s = eval([s.X, s.Y]);
s = s(s(:,1)>0, :);
s(:,1) = (s(:,1)-0.5)/30;
s
l = s(1); a = s(2);
y2 = gammainc(l*30, a * (x .^ b), 'upper');
plot(x, y2, 'b');