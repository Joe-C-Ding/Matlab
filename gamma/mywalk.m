function [  ] = mywalk( n )
%MYWALK brown motion.
%   Detailed explanation goes here

x = randn(1, n);
z = [0 cumsum(x)];

clf;
plot(0:n, z);

end

