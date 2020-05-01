get_ready();

%%
n = 15;
k = 5;

rst = zeros(n, k);
rst(:,1) = 1;
rst(1,:) = 1;
for i = 2:n
    for j = 2:k
        if j > i
            rst(i,j) = rst(i,i);
        else
            for l = 1:j
                if i-l < 1
                    rst(i,j) = rst(i,j) + 1;
                else
                    rst(i,j) = rst(i,j) + rst(i-l, l);
                end
            end
        end
    end
end

rst

%%
end_up(mfilename)