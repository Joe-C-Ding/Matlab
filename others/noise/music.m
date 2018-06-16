start_tic = tic;
clf;

t = 0.5;

%    C  C+ D  D+ E  F  F+ G  G+ A  A+ B
k = [1  0  1  0  1  1  0  1  0  1  0  1  1];
Hz = 440 * 2.^(find(k)./12);

Fs = 8192;
x = linspace(0, t, t*Fs);
w = 2*pi*Hz;

for i = 1:length(Hz)
    y = sin(bsxfun(@times, w, x.'));
end
% plot(x, y);

sound(y(:), Fs);

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));
