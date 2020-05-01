function in = collatz(in)
% collatx:
%   even -> even / 2
%   odd  -> odd * 3 + 1
%   does all numbers finally coverge to 1?

unit = in == 1;
odds = mod(in, 2) == 1;
in(odds & ~unit) = 3 * in(odds & ~unit) + 1;
in(~odds) = in(~odds) / 2;

end

