function [ alpha, b, lumbda ] = estgamma3( aN )
%ESTGAMMA3 [ alpha, b, lumbda ] = estgamma3( aN )
%   Detailed explanation goes here
e3 = tic;

bl = 2;
bu = 10;

a = estgamma(aN, bl);
bb = estgamma2(aN, a);
while bb < bl
    bu = bb; bl = bb/10;
    a = estgamma(aN, bl);
    bb = estgamma2(aN, a);
end
bl = bb;

a = estgamma(aN, bu);
bb = estgamma2(aN, a);
while bb > bu
    bl = bb; bu = 2*bb;
    a = estgamma(aN, bu);
    bb = estgamma(aN, a);
end
bu = bb;

while 1
    a = estgamma(aN, bl);
    bb = estgamma2(aN, a);
    
    tempb = (bu + bb)/2;
    a = estgamma(aN, tempb);
    bb = estgamma2(aN, a);
    if bb > tempb
        bl = bb;
    elseif bb < bu
        bu = bb;
    end
    
    a = estgamma(aN, bu);
    bb = estgamma2(aN, a);
    
    tempb = (bb + bl)/2;
    a = estgamma(aN, tempb);
    bb = estgamma2(aN, a);
    if bb < tempb
        bu = bb;
    elseif bb > bl
        bl = bb;
    end
    
    if abs(bu - bl) < 1e-5
        break;
    end
end

b = (bl + bu)/2;
[alpha, lumbda] = estgamma(aN, b);

toc(e3)
end

