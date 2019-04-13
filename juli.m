function lucheng=juli(zuobiao) 
length=max(size(zuobiao)); 
s=0; 
for i=2:length 
    s=s+sqrt(sum((zuobiao(:,i)-zuobiao(:,i-1)).^2)); 
end 
if length~=2 
    s=s+sqrt(sum((zuobiao(:,1)-zuobiao(:,length)).^2)); 
end 
    lucheng=s; 
 
 
