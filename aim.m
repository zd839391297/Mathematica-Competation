function [y] = aim(x)
%UNTITLED4 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
y=0;
    for i=1:box_num
        y=y+norm(PR(i,:)-x);
    end
end

