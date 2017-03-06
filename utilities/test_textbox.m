start_tic = tic;
figure(1);
clf; ax = gca;

hold(ax, 'on');
grid(ax, 'on');

x = linspace(-2*pi, 2*pi);
plot(ax, x, sin(x));

pos = {'N','NE','E','SE','S','SW','W','NW', 'C'};
str = {'test a long line ...'};
for i = 1:length(pos)
    h_tb = textbox(ax, str, pos{i});
    
%     delete(h_tb);
end


fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));