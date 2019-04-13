clear all
clc
L=[31 33;12	13;3 4;28 29;34	35;6 7;20 22;22	23;31 32;10	13;32 33;14	15;35 39;26	28;36 37;6	4;19	30;11	14;24	22;1	42;27	28;20	21;26	31;38	39;9	10;39	40;40	41;27	36;31	29;2	3;13	16;2	1;23	25;29	33;4	5;37	38;18	19;6	5;30	31;19	21;44	25;44	36;24	44;37	35;17	45;10	11;1	9;15	18;10	14;8	11;34	40;25	27;21	30;1	8;11	18;12	17;15	20;34	33;3	12;43	17;21	26;44	34;16	24;5	17;45	24;33	41];
LT=ones(66,2);
LT(:,1)=L(:,2);
LT(:,2)=L(:,1);
R=L(:,1)';
C=L(:,2)';
W=[1.84 4.80 4.86 4.92 4.93 5.09 5.79 6.00 6.33 6.54 6.61 7.00 7.08 7.27 7.68 8.01 8.26 8.32 9.12 9.49 9.68 9.86 10.21 10.58 10.75 10.89 11.41 11.96 12.24 12.55 12.62 12.88 13.43 13.63 14.10 14.48 14.90 15.02 15.58 16.28 16.40 16.62 17.44 17.49 17.60 17.87 18.44 18.92 19.41 21.00 21.80 22.43 22.85 24.42 26.98 28.48 28.78 28.88 30.89 34.80 35.64 36.85 39.06 42.28 45.17 58.40 ]';
G=sparse(R,C,W);
g=G+G';
%view(biograph(g,[],'ShowW','ON'));
%[dist,path]=graphshortestpath(g,12,16);
%I=[];
PH=[4,43,24,41,31,32,11];
PHC=nchoosek(PH,2);
LA=ones(66,1);
Ld=ones(21,2);
i=1;
m=1;
while i<=66 
    if LA(i)==1
        j=1;
        while j<=21
            [dist1,path1]=graphshortestpath(g,PHC(j,1),L(i,1));
            [dist2,path2]=graphshortestpath(g,L(i,2),PHC(j,2));
            [dist3,path3]=graphshortestpath(g,PHC(j,2),L(i,1));
            [dist4,path4]=graphshortestpath(g,L(i,2),PHC(j,1));
            Ld(j,1)=dist1+dist2+W(i);
            Ld(j,2)=dist3+dist4+W(i);
            j=j+1;
        end
        [jv,f]=find(Ld==min(min(Ld)));
        %i
        min(min(Ld))
        if f==1
            [dist1,path1]=graphshortestpath(g,PHC(jv,1),L(i,1));
            [dist2,path2]=graphshortestpath(g,L(i,2),PHC(jv,2));
            temp=[path1,path2]
            k=1;
            while k<length(temp)
                temp2=[temp(k),temp(k+1)];
                x=find(ismember(L,temp2,'rows'));
                LA(x)=2;                
                x=find(ismember(LT,temp2,'rows'));
                LA(x)=2;
                k=k+1;
            end
        else
            [dist3,path3]=graphshortestpath(g,PHC(jv(1),2),L(i,1));
            [dist4,path4]=graphshortestpath(g,L(i,2),PHC(jv(1),1));
            temp=[path3,path4]
            k=1;
            while k<length(temp)
                temp2=[temp(k),temp(k+1)];
                x=find(ismember(L,temp2,'rows'));
                LA(x)=2;                
                x=find(ismember(LT,temp2,'rows'));
                LA(x)=2;
                k=k+1;
            end
        end
        i=i+1;
        m=m+1;
    else
        i=i+1;
    end
end
m

