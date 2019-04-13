clear all
clc
L=[31 33;12	13;3 4;28 29;34	35;6 7;20 22;22	23;31 32;10	13;32 33;14	15;35 39;26	28;36 37;6	4;19	30;11	14;24	22;1	42;27	28;20	21;26	31;38	39;9	10;39	40;40	41;27	36;31	29;2	3;13	16;2	1;23	25;29	33;4	5;37	38;18	19;6	5;30	31;19	21;44	25;44	36;24	44;37	35;17	45;10	11;1	9;15	18;10	14;8	11;34	40;25	27;21	30;1	8;11	18;12	17;15	20;34	33;3	12;43	17;21	26;44	34;16	24;5	17;45	24;33	41];
point_num=55;
port_num=11;
hospital_num=4;
load_num=66;
flight=40*79*2/60;
R=L(:,1)';
C=L(:,2)';
W=[1.84 4.80 4.86 4.92 4.93 5.09 5.79 6.00 6.33 6.54 6.61 7.00 7.08 7.27 7.68 8.01 8.26 8.32 9.12 9.49 9.68 9.86 10.21 10.58 10.75 10.89 11.41 11.96 12.24 12.55 12.62 12.88 13.43 13.63 14.10 14.48 14.90 15.02 15.58 16.28 16.40 16.62 17.44 17.49 17.60 17.87 18.44 18.92 19.41 21.00 21.80 22.43 22.85 24.42 26.98 28.48 28.78 28.88 30.89 34.80 35.64 36.85 39.06 42.28 45.17 58.40 ]';
G=sparse(R,C,W);
g=G+G';
%view(biograph(g,[],'ShowW','ON'));
%[dist,path]=graphshortestpath(g,12,16);
%I=[];
P=[1,11,41,43,36,45,42,4,24,32,38];
H=[41,31,32,11];
PC=nchoosek(P,3);
PR=ones(165,3);
i=1;
while i <=165
    PM=[PC(i,:),H];
    PX=nchoosek(PM,2);
    j=1;
    while j<=load_num
        k=1;
        while k<=21
            [dist1,path1]=graphshortestpath(g,PX(k,1),L(j,1));
            [dist2,path2]=graphshortestpath(g,PX(k,2),L(j,2));
            if dist1+dist2+W(j)<=flight
                break
            end
            [dist3,path3]=graphshortestpath(g,PX(k,2),L(j,1));
            [dist4,path4]=graphshortestpath(g,PX(k,1),L(j,2));
            if dist3+dist4+W(j)<=flight
                break    
            end
            k=k+1;
        end    
        if k==22
            i=i+1;
            break
        else
            j=j+1;
        end
    end 
    if j==load_num+1
        fprintf("find new port")
        PR(i,:)=PC(i,:);
    end
    i=i+1;
end

