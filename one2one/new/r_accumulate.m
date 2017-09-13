function [ n, R ] = r_accumulate( func, spectrum, Du, dn, R_tol )
%R_ACCUMULATE [ n, R ] = r_accumulate( func, spect )
%   此处显示详细说明
narginchk(2, 5)
if nargin < 3 || Du == []
    Du = [1 0];
end
if nargin < 4 || dn == []
    dn = 1e3;
end
if nargin < 5 || R_tol == []
    R_tol = 1e-4;
end

ns = size(spectrum, 1);

n = 0;
R = 1;
mu = 0;
sig = 0;

stop = false;
while R(end) > R_tol
    for i = 1:ns
        stress = spectrum(i, 1);
        cycle =  spectrum(i, 2);
        
        while cycle > 0
            if cycle > dn
                nc = dn;
                cycle = cycle - dn;
            else
                nc = cycle;
            end
            [m, s] = func(stress, nc);
            mu = mu + m;
            sig = hypot(sig, s);
            
            r = normcdf(0, mu - Du(1), sqrt(sig^2 - Du(2)^2));
            
            n = [n; n(end) + nc];  %#ok<AGROW>
            R = [R; r]; %#ok<AGROW>
            
            if r <= R_tol
                stop = true;
            end
        end
        
        if stop
            break;
        end
    end
end

end

