get_ready(true)

%% ln6 ^ ln5 ^ ... ^ ln2 ~ 3.141577
x = log(2:6);
y = 1;

for i = 1:length(x)
    y = x(i) ^ y;
end

[y, y - pi]

%% ln{23} ~ 3.1355
log(23)

%%
end_up(mfilename)