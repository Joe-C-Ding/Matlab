start_tic = tic;
% close all but one figure, or creat one if none is there.
h = groot; h = h.Children;
if length(h) > 1
    i = ([h.Number] ~= 1);
    close(h(i)); h = h(~i);
end
clf(h);

pod = {"far","near","mag","elec"};
xls = xlsread('POD.xls', 1, 'A:H');

fout = 'POD.mat';

for i = 1:length(pod)
    data = xls(:,[2*i-1, 2*i]);
    data = reshape(data(~isnan(data)), [], 2);

    x = data(:,1);
    [x, I] = sort(x);
    y = data(I,2)/100;

    gap = 1 - mean(y(end-10:end));
    if gap < 0
        gap = 0;
    end
    yfit = y + gap;

    curve = @(x, xdata) 1./(1+exp(-(x(1) + x(2).*reallog(xdata))));
    opt = optimoptions('lsqcurvefit', 'Display','off');
    p = lsqcurvefit(curve, [1 1], x, yfit, [],[], opt);

    xfit = linspace(0, 20).';
    yfit = curve(p, xfit) - gap;
    y1 = find(yfit>=0, 1);
    if y1 == 1
        y1 = 2;
    end
    yfit(y1) = 0;
    yfit(1:y1-1) = nan;

%     plot(x, y, 'r');
    plot(xfit, yfit, line{i});

    varn = strcat('pod_', pod{i});
    fprintf('%s:\tz = %.3f + %.3f * ln(x)\tgap: %.3f\n',...
        varn, p(1), p(2), gap);
    
    eval(strcat(varn, '= [xfit yfit];'));
    if exist(fout, 'file')
        save(fout, varn, '-append');
    else
        save(fout, varn);
    end
end

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));