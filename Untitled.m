clear all
clc
box_num=0;
L=30;
W=30;
H=20;
PR=zeros(200,3);
XL=zeros(200,1);
XL(:,1)=L;
YL=zeros(200,1);
YL(:,1)=W;
ZL=zeros(200,1);
ZL(:,1)=H;
for i=1:box_num
    x0=[0 0 0];
    A=;
    b=;
    Aeq=[];
    beq=[];
    [PR(:,1)+XL;PR(:,2)+YL;PR(:,3)+ZL
    [errmsg,Z,X]=fmincon(aim,x0,intlist,lb,ub,A,b,Aeq,beq)
    if errmsg ==""
        PR(i:)=x;
        LR(i)=fval;
        box_num=box_num+1;
    else
        print("can not put boxes any more")
        break
end
