classdef invwbl
    %INVWBL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        B
    end
    
    methods
        function obj = invwbl(b)
            if nargin < 1
                b = 1;
            elseif ~isscalar(b)
                error('invwbl: onle accepts b as scalar');
            elseif b <= 0
                error('invwbl: requre b > 0');
            end
            obj.B = b;
        end

        function F = cdf(obj, x)
            F = 1 - wblcdf(-x, 1, obj.B);
        end

        function f = pdf(obj, x)
            f = wblpdf(-x, 1, obj.B);
        end

        function x = icdf(obj, F)
            x = -wblinv(1-F, 1, obj.B);
        end
    end
    
end

