function p = errorfun(S, varargin)
    d = eta(0, t*n_tot*coef([eps, 1-eps]), [eps, 1-eps], s1);
    if (dc > nanmax(d))
        p = 0;
    elseif (dc < nanmin(d))
        p = 1;
    else
        warning
    end
end