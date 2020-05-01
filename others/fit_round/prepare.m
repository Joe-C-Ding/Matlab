get_ready();
%%
xlsfile = 'data.xlsx';

d = xlsread(xlsfile, 'd', 'A1:B99');
x = xlsread(xlsfile, 'x', 'A1:B99');
y = xlsread(xlsfile, 'y', 'A1:B99');

x_data = zeros(size(x));
x_data(:,1) = x(:,1);
x_data(:,2) = -x(:,2);

y_data = zeros(size(y));
y_data(:,1) = y(:,2);
y_data(:,2) = -y(:,1);

d_data = zeros(size(d));
d_data(:,1) = (d(:,1) - d(:,2)) ./ sqrt(2);
d_data(:,2) = (d(:,1) + d(:,2)) ./ sqrt(2) - 40;

ltype = ["kx", "kx", "kx"];
data = {x_data, y_data, d_data};
for i = 1:length(data)
    p = data{i};
    plot(p(:,1), p(:,2), ltype(i));
    plot(
end

grid off
xticks([])
yticks([])
daspect([1,1,1])
%%
end_up(mfilename);