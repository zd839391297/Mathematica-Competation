clear;
clc;
M=inf;
a(1,1)=0;a(1,36)=10.3;a(1,37)=5.9;a(1,38)=11.2; a(1,50)=6.0;
a(2,2)=0;a(2,50)=9.2; a(2,5)=8.3;a(2,3)=4.8;
a(3,3)=0;a(3,39)=8.2; a(3,38)=7.9;
a(4,4)=0;a(4,39)=12.7; a(4,8)=20.4;
a(5,5)=0;a(5,6)=9.7; a(5,39)=11.3; a(5,48)=11.4;
a(6,6)=0;a(6,7)=7.3;a(6,47)=11.8; a(6,48)=9.5;
a(7,7)=0;a(7,47)=14.5; a(7,40)=7.2; a(7,39)=15.1;
a(8,8)=0;a(8,40)=8.0;	
a(9,9)=0;a(9,40)=7.8; a(9,41)=5.6;
a(10,10)=0;a(10,41)=10.8;
a(11,11)=0;a(11,42)=6.8; a(11,45)=13.2; a(11,40)=14.2;
a(12,12)=0;a(12,43)=10.2; a(12,42)=7.8;a(12,41)=12.2;
a(13,13)=0;a(13,45)=9.8;a(13,44)=16.4;a(13,42)=8.6; a(13,14)=8.6;
a(14,14)=0;a(14,43)=9.9; a(14,15)=15.0;
a(15,15)=0;a(15,44)=8.8;
a(16,16)=0;a(16,17)=6.8;a(16,44)=11.8;
a(17,17)=0;a(17,22)=6.7; a(17,46)=9.8;
a(18,18)=0;a(18,46)=9.2; a(18,45)=8.2; a(18,44)=8.2;
a(19,19)=0;a(19,20)=9.3; a(19,45)=8.1; a(19,47)=7.2;
a(20,20)=0;a(20,21)=7.9;a(20,25)=6.5; a(20,47)=5.5;
a(21,21)=0;a(21,23)=9.1;a(21,25)=7.8; a(21,46)=4.1;
a(22,22)=0;a(22,23)=10.0; a(22,46)=10.1;
a(23,23)=0;a(23,24)=8.9; a(23,49)=7.9;
a(24,24)=0;a(24,27)=18.8; a(24,49)=13.2;
a(25,25)=0;a(25,49)=8.8; a(25,48)=12.0;
a(26,26)=0;a(26,27)=7.8; a(26,49)=10.5; a(26,51)=10.5;
a(27,27)=0;a(27,28)=7.9;
a(28,28)=0;a(28,52)=8.3; a(28,51)=12.1;
a(29,29)=0;a(29,52)=7.2; a(29,51)=15.2; a(29,53)=7.9;
a(30,30)=0;a(30,32)=10.3; a(30,52)=7.7;
a(31,31)=0;a(31,33)=7.3;a(31,32)=8.1; a(31,53)=9.2;
a(32,32)=0;a(32,33)=19;a(32,35)=14.9;
a(33,33)=0;a(33,35)=20.3; a(33,36)=7.4;
a(34,34)=0;a(34,35)=8.2; a(34,36)=11.5; a(34,37)=17.6;
a(35,35)=0;
a(36,36)=0;a(36,53)=8.8;a(36,37)=12.2;
a(37,37)=0;a(37,38)=11.0;
a(38,38)=0;a(38,50)=11.5;
a(39,39)=0;
a(41,41)=0;
a(42,42)=0;
a(43,43)=0;
a(44,44)=0;a(44,45)=15.8;
a(45,45)=0;
a(46,46)=0;
a(47,47)=0;
a(48,48)=0;a(48,49)=14.2; a(48,50)=19.8;
a(49,49)=0;
a(50,50)=0;a(50,53)=12.9;a(50,51)=10.1;
a(51,51)=0;
a(52,52)=0;
a(53,53)=0;
% ��1��2 ��3����35��ʾ35���壺��36��37����53��ʾ����������50��ʾ������������
b=a+a';b(find(b==0))=M;
for i=1:53
    b(i,i)=0;
end
[m n]=size(b);
k=1;
for i=1:m
    for j=1:n
        if  (b(i,j)==0)||(b(i,j)==inf)
        else
              x1(k)=i;
              y(k)=j;
              z(k)=b(i,j);
              k=k+1;
        end
    end
end
Q=[x1;y;z]';
k=0;
d=zeros(1,n);
for i=1:m
    for j=1:n
     if (b(i,j)==0)||(b(i,j)==inf)
     else 
         d(i)=d(i)+1;
         x2(i)=i;
     end
    end
end
k=1;
t=mod(d,2);
for i=1:m
    if t(i)==1
        x3(k)=i;
        k=k+1;
    end
end
[m n]=size(x3);
for i=1:n
 for j=1:n
     E(i,j)=b(x3(i),x3(j));
 end
end
k=1;
[D,path]=floyd(b);
for i=1:n
    for j=1:n
        if i==j
        else    
     [L,R]=router(D,path,x3(i),x3(j));
              x4(k)=x3(i);
              y4(k)=x3(j);
              z41(k)=max(L(:));
              z4(k)=150-z41(k);
              k=k+1;
        end
        end
end
Y1=[x4;y4;z41]';
Y=[x4;y4;z4]';
nMM=grMaxMatch(Y);
for i=1:13
  A(i,:)=Y1(nMM(i),:);
  end
 for i=1:13
     j=1;
     k=2;
     disp('��Ҫ�ӵı�Ϊ��')
[l,r]=router(D,path,A(i,j),A(i,k));
 end
e=hujuzhen(b);
f=[2 3 4.8;10 41 10.8;11 42 6.8;12 43 10.2;43 14 9.9;18 44 8.2;19 45 8.1;22 17 6.7;24 49 13.2;49 48 14.2;26 49 10.5;27 28 7.9;29 52 7.2;31 35 7.3;35 36 7.4;34 35 8.2];
e=[e;f];
E=[e(:,1) e(:,2)];
[eu,cEu]=grIsEulerian(E);
if eu==1
    disp('�ҵ������·');
    [m n]=size(cEu);
    shortrouter=zeros(m,3);
    for i=1:m
        shortrouter(i,:)=e(cEu(i),:);
        juli=sum(shortrouter(:,3));
    end
    juli
 [m,n]=size(shortrouter);
t=0;
for i=2:m
   if shortrouter(i,1)==shortrouter(i-1,2)
   else
     t=shortrouter(i,1);
     shortrouter(i,1)=shortrouter(i,2);
     shortrouter(i,2)=t;
   end
   end
 zx=[shortrouter(1,1)  shortrouter(:,2)']';
[m,n]=size(zx);
n=sqrt(m);
n=floor(n);
t=[0];
k=1;
g=1;
l=n;
j=2;
while j<=m-1
for i=k:l
     x1=g;
     t=[t x1];
     j=j+1;
if j>m-1
break
end
 end
 g=g+1;
 k=l;
 l=l+n-1;
 end
 t=[t g]';
 v=[n/2];
for i=1:n
    x=1:n;
    v=[v x];
    end
     j=m-n*n-1;
     if j>0
     x=1:j-1;
      end
     vl=[v x n/2]';
     Q=[t vl zx];
     c1=[1:107]';
     c2=[2:108]';
     c3=shortrouter(:,3);
     C=[c1 c2 c3];
     grPlot(Q,C,'g','%d','');
     title('\bf���·��Ϊ��');
else
    disp('û�����·');
end
load data
v=[x -y];
 grPlot(v,shortrouter,'g','%d','');
 title('\bf���·��Ϊ��');
 function A=hujuzhen(e)
[m n]=size(e);
k=1;
for i=1:m
    for j=i:n
        if  (e(i,j)==0)||(e(i,j)==inf)
        else
              x(k)=i;
              y(k)=j;
              z(k)=e(i,j);
              k=k+1;
        end
    end
end
A=[x;y;z]';
a=[1	1	2	3	4	4	5	5];
b=[2	3	4	2	3	5	3	4];
w=[1	1	1	1	1	1	1	1];
n=5;
m=5;
k=length(a);
x1=zeros(m,n);
for i=1:k
    x1(a(i),b(i))=w(i);
end
