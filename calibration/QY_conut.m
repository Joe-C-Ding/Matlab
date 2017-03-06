start_tic = tic;
figure(1);
clf; ax = gca;

if ~exist('Q1', 'var')
    load Q1.mat
    Q1 = val;
    load Y1.mat
    Y1 = val;
    load 'Calculated Speed.mat'
    speed = val;
    clear val;
end

fs = 2000;

Qedge = 0:0.5:120;
Yedge = -30:0.25:30;

Qn = discretize(Q1, Qedge);
Yn = discretize(Y1, Yedge);
speed = speed / pi / 860 / fs;
N1 = zeros(length(Qedge), length(Yedge));

for i = 1:length(Q1);
    if ~isnan(Qn(i)) && ~isnan(Yn(i))
        N(Qn(i), Yn(i)) = N(Qn(i), Yn(i)) + speed(i);
    end
end

[Q, Y] = meshgrid(Qedge, Yedge);
surface(Q, Y, N)

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));