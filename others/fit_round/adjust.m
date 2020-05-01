get_ready();
%%
load data

n = length(measure);
d = zeros(n);
for i = 1:n
    for j = i+1:n
        d(i,j) = norm(diff(measure([i j],:)));
        d(j,i) = d(i,j);
    end
end

ind = d < 1.5;
group = {1:2, 3:5, 6:10, 11:16, 17:20, 21:26, 27:31, 32:35, 36:37,};

centered = zeros(length(group), 2);
for i = 1:length(group)
    p = measure(group{i},:);
    plot(p(:,1), p(:,2), 'o');
    
    centered(i,:) = mean(p);
end

h = plot(centered(:,1), centered(:,2), 'rd');
h.MarkerSize = 10;
h.MarkerFaceColor = 'r';

save('data', 'centered', '-append')
%%
end_up(mfilename);