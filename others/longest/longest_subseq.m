start_tic = tic;
clf;

p = primes(100000);
lp = length(p);
disp(lp^3 * fact)

kmax = zeros(2, lp, 'int32');
for i = 1:lp
    for j = (i+1):lp
        k = (p(j:end) - p(i)) ./ (p(j) - p(i));

        if k(end) <= kmax(1,i)
            continue;
        end
        
        l = 2;
        for n = k
            if n > l
                break;
            elseif n == l
                l = l+1;
            end
        end
        
        if l > kmax(1,i)
            kmax(:,i) = [l; p(j)-p(i)];
        end
    end
end

elsp = toc(start_tic);
fact = elsp / lp^3;
fprintf('%s elapsed: %f s\n', mfilename, elsp);