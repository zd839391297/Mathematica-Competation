R=[1 1 2 4 1 2 3 3 5 7 3 4 5 6 7 8]; 
C=[2 3 3 3 4 5 5 6 6 6 7 7 8 8 8 7];
W=[2 8 6 7 1 1 5 1 3 4 2 9 8 6 3 0];
G=sparse(R,C,W);
g=G+G';
view(biograph(g,[],'ShowW','ON'));
[dist,path]=graphshortestpath(G,1,8);