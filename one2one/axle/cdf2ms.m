function [m, s] = cdf2ms(mean, Tg)
%CDF2MS Summary of this function goes here
%   Detailed explanation goes here

m = reallog(mean);
s = log(Tg)/norminv(0.9)/2;

end

