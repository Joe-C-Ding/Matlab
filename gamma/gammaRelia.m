function [ F, R ] = gammaRelia( POND, a, l, p, t)
%GAMMARELIA Summary of this function goes here
%   Detailed explanation goes here
D = 16;

diameter = 860;
p = p * 10e6/pi/diameter;

n = floor(t/p);
if t == n*p, n = n-1; end
p = p * (1:n);

F = [0 0];

end

