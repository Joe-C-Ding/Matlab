start_test = tic;
clf;

interval = 8.74196963257248;

Theta = [
    6.46017892342081e-19	2.63442078342551	49.7013328962502
%     4.4369890460046e-18     2.4666170988831     14.8588377172234
%     5.47247315026415e-20	2.71493814479195	18.9437368347109
%     5.59046227096689e-21	2.78724439321858	7.4692936907018
%     1.69665945283884e-21	2.82775529449274	4.83116395817372
%     4.79175970489209e-22	2.68619514296237	0.0803749083437721
    2.95194377697143e-23    2.82775529449274    0.0676786238444302
];

t = linspace(3, 15, 3e3);
N = zeros(size(t));
labs = cell(size(Theta, 1), 1);

for i = 1:size(Theta, 1)
    a = Theta(i, 1);
    b = Theta(i, 2);
    l = Theta(i, 3);
    labs{i} = sprintf('a=%.2g b=%.2f l=%.2f', a, b, l);

    for j = 1:length(t)
        N(j) = E_testcount(km2r(t(j)));
    end
    
	hold on; plot(t, N);
end

% grid on;
% legend(labs);
legend('小分散性算例对比', 'Zerbst 算例');
plot([interval interval], [0 8], 'k--');
xlabel('探伤周期（万公里）');
ylabel('期望探伤次数 N');

axis([3 15 2.2 11]);

toc(start_test);