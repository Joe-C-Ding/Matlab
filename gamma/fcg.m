function [ aN ] = fcg( failure, counts )
tic;
%FCG Summary of this function goes here
%   Detailed explanation goes here

a0 = 5;

C = 4.53e-10; %1.6475e-11;
n = 2.09; %3;

p = 1.3; %0.25;
q = 0.001; %0.25;
Ko = 7.39; %2;
Kjc = 81.0;

alpha = 2.5;
A = [ polyval([0.05, -0.34, 0.825], alpha) * cos(0.3*pi/2)^(1/alpha), ...
      0.3 * polyval([-0.071, 0.415], alpha)];
A(4) = 2*A(1) + A(2) - 1;
A(3) = 1 - A(1) - A(2) - A(4);

R = -1.0;
if R >= 0
    f = max(R, polyval(fliplr(A) ,R));
else
    f = A(1) + A(2)*R;
end

aN = zeros(counts, 1);
parfor (c = 1:counts, 4)
    t = 0;
    a = a0;

    w = zeros(2000, 1);
    while max(w) < 150
        w = wblrnd(59.5, 2.5, 2000, 1);
    end
    [sc, st] = hist(w, 9);
    sp = sortrows([randperm(9)' st' sc']);
    stress = sp(:, 2:3);

    Ko = normrnd(7.39, 0.857);
    loopdone = false;
    while ~loopdone
    for i = 1:9
	Kmax = stress(i, 1) * sqrt(pi * a/1000);
	Keff = (1-f) / (1-R) * Kmax;
	Kp = Ko / Kmax;
	if Kp > 1
	    t = t + stress(i, 2);
	    continue
	elseif Kmax > Kjc
	    aN(c) = t;
	    loopdone = true;
	    break
	end
	
	mu = 1000 * C*Keff^n * (1-Kp)^p / (1-Kmax/Kjc)^q;
	da = lognrnd(log(mu)-0.5*(0.4^2), 0.4, stress(i, 2), 1);

	a = a + sum(da);
	t = t + stress(i, 2);
	if a >= failure
	    aN(c) = t;
	    loopdone = true;
	    break;
	end
    end % for
    end % while
end
toc;

end

