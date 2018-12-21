start_tic = tic;
% close all but one figure, or creat one if none is there.
h = get(groot, 'Children');
if length(h) > 1
    i = ([h.Number] == 1);
    close(h(~i)); h = h(i);
end
clf(h);

n = 500;
q = zeros(1, n);
p = zeros(1, n);

c = 5/6^3;
q(1) = 1;
q(2) = 1 - 1/6/6;
q(3) = q(2) - c;

p(1) = 0;
p(2) = 1/6/6;
p(3) = c;

for k = 4:n
    p(k) = c * q(k-3);
    q(k) = q(k-1) - p(k);
end
plot(p(2:end));
1 + sum(q)

N = 5000;
ps = zeros(1, n);
for i = 1:N
    six = 0;
    for k = 1:n
        if randi(6) == 6
            six = six + 1;
            if six == 2
                ps(k) = ps(k) + 1;
                break;
            end
        else
            six = 0;
        end
    end
    if k == 300
        ps(k) = ps(k) + 1;
    end
end
ps = ps/N;
plot(ps(2:end));
sum((1:n).*ps)

xlim([1 100]);

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));