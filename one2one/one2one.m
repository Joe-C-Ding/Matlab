function [ Dpdf, Dmean, Dstd ] = one2one( Npdf, k, a )
%ONE2ONE [ Dpdf ] = one2one( Npdf, k, a )

% Dpdf(d) * (kn^a)' = Npdf(n)
% Dpdf(d) = Npdf(n) / akn^(a-1)
% where n = (d/k)^(1/a);
Dpdf = @(d)Npdf( (d/k).^(1/a) ) ./ ( (d/k).^(1-1/a) ) / a/k;

if nargout >= 2
    Dmean = integral(@(d)d.*Dpdf(d), 0, inf);
    if nargout >= 3
        Dstd = integral(@(d)d.^2.*Dpdf(d), 0, inf) - Dmean^2;
        Dstd = sqrt(Dstd);
    end
end

end

