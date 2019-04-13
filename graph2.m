R=[1 1 2 4 1 2 3 3 5 7 3 4 5 6 7 8]; 
C=[2 3 3 3 4 5 5 6 6 6 7 7 8 8 8 7];
W=[2 8 6 7 1 1 5 1 3 4 2 9 8 6 3 0];
G=sparse(R,C,W);
g=G+G';
view(biograph(g,[],'ShowW','ON'))
graphallshortestpaths(g);
[dist,path]=graphshortestpath(G,1,8);%最短路
h=view(biograph(g,[],'showW','on'));
edges=getedgesbynodeid(h,get(h.Nodes(path),'ID'));
set(h.Nodes(path),'color',[1 0 0]);
[ST,pred] = graphminspantree(g);%最小生成树
view(biograph(ST,[],'ShowArrows','off','ShowWeights','on'));
[M,F,K] = graphmaxflow(G,1,6);%最大流
h = view(biograph(G,[],'ShowWeights','on'));
view(biograph(F,[],'ShowWeights','on'));
set(h.Nodes(K(1,:)),'Color',[1 0 0]);

