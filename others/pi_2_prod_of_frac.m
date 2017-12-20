start_tic = tic;
clf;

N = 5e5;
a = 2;
b = 1;

%% pi/2 = 2/1 * 2/3 * 4/3 * 4/5 * 6/5 * 6/7 * ...

i = 0;
p = a / b;
while i < N
    i = i + 1;
    a = a + 2;
    b = b + 2;
    p = p * (a-2) * a / b / b;
end

p - pi / 2  % ~= 7e-7

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));