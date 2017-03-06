function n = E_testcount(i)
%E_TESTCOUNT n = E_testcount(i)
%   Detailed explanation goes here

N = 1e3;

p = diff(Ft(i*(1:N)));
n = p * (1:N-1)';
end

