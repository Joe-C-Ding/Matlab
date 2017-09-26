function [ stop ] = test_fun( x, optimValues, state )
%TEST_FUN 此处显示有关此函数的摘要
%   此处显示详细说明
stop = false;

cnt = optimValues.funccount;
if isequal(state,'iter')
    text(x, 1-0.005*cnt, num2str(cnt));
end

end

