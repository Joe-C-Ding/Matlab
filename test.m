get_ready();

%%
k = 0.1;
N = 100;

x = exprnd(20, N, 1);
e = normrnd(0, 1, N, 1);
y = k * x + 1000 + e;

scatter(x, y);
r = corr(x, y)

%%
end_up(mfilename)