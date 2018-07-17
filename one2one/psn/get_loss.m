function [ loss_fun ] = get_loss( stat, dist, varargin)
%LOSS loss_fun = loss( curve, cdf, varargin)
%   stat: @(para, ...) stat(para, ...)
%   dist: string, dist_name
%   loss_fun: loss = norm(ecdf-cdf);

    function loss = calc_loss(x)  
        v = reshape(stat(x, varargin{:}), [], 1);
        if strcmpi(dist, 'wbl')
            % 'wbl' to use wblpwm(), or 'weibull' to use build-in prob
            % object.
            [ shp, scl, loc ]  = wblpwm(v);
            
            pd = struct;
            pd.cdf = @(v) wblcdf(v-loc,scl,shp);
        elseif strcmpi(dist, 'weibull')
            pd = fitdist(v(v>0), dist);
        else
            pd = fitdist(v, dist);
        end
        
        n = numel(v);
        f = ((1:n).'-0.3) ./ (n+0.4);
        
        cdf = pd.cdf(v);
        if any(cdf <= 0)
            loss = inf;
        else
            loss = norm(f-pd.cdf(sort(v)));
        end
    end

    loss_fun = @calc_loss;
end

