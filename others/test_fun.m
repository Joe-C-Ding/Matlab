function [ stop ] = test_fun( x, optimValues, state )
%TEST_FUN �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
stop = false;

cnt = optimValues.funccount;
if isequal(state,'iter')
    text(x, 1-0.005*cnt, num2str(cnt));
end

end

