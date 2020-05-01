get_ready();
%%
xlsfile = 'data.xlsx';

d = xlsread(xlsfile, 'd', 'A1:B99');
x = xlsread(xlsfile, 'x', 'A1:B99');
y = xlsread(xlsfile, 'y', 'A1:B99');

dd = xlsread(xlsfile, 'dd', 'A1:B99');
xx = xlsread(xlsfile, 'xx', 'A1:B99');
yy = xlsread(xlsfile, 'yy', 'A1:B99');

x_data = zeros(size(x));
x_data(:,1) = x(:,1);
x_data(:,2) = -x(:,2);

xx_data = zeros(size(xx));
xx_data(:,1) = xx(:,1);
xx_data(:,2) = -xx(:,2);

y_data = zeros(size(y));
y_data(:,1) = y(:,2);
y_data(:,2) = -y(:,1);

yy_data = zeros(size(yy));
yy_data(:,1) = yy(:,2);
yy_data(:,2) = -yy(:,1);

d_data = zeros(size(d));
d_data(:,1) = (d(:,1) - d(:,2)) ./ sqrt(2);
d_data(:,2) = (d(:,1) + d(:,2)) ./ sqrt(2) - 40;

dd_data = zeros(size(dd));
dd_data(:,1) = (dd(:,1) - dd(:,2)) ./ sqrt(2);
dd_data(:,2) = (dd(:,1) + dd(:,2)) ./ sqrt(2) - 40;


ltype = ["kx", "ko", "ks", "bx", "bo", "bs"];
data = {x_data, y_data, d_data, xx_data, yy_data, dd_data};
measure = [];
for i = 1:length(data)
    p = data{i};
    plot(p(:,1), p(:,2), ltype(i));
    
    measure = [measure; p]; %#ok<AGROW>
end

[~, I] = sort(measure(:,1));
measure = measure(I, :);

save('data', 'measure')
%%
end_up(mfilename);