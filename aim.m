function [y] = aim(x)
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
y=0;
    for i=1:box_num
        y=y+norm(PR(i,:)-x);
    end
end

