zuobiao=[0.37 0.75 0.45 0.76 0.71 0.07 0.42 0.59  0.32 0.6 0.3 0.67 0.62 0.67 0.20 ... 
    0.35 0.27 0.94 0.82 0.37 0.61 0.42 0.6 0.39 0.53 0.4 0.63 0.5 0.98 0.68; 
    0.91 0.87 0.85 0.75 0.72 0.74 0.71 0.69 0.64 0.64 0.59 0.59 0.55 0.55 0.5... 
    0.45 0.43 0.42 0.38 0.27 0.26 0.25 0.23 0.19 0.19 0.13 0.08 0.04 0.02 0.85] 
length=max(size(zuobiao)); 
%????????.. 
 
zhixu=randperm(length)      %??????????¡¤??????????? 
temp=zuobiao(1,:); 
newzuobiao(1,:)=temp(zhixu); 
temp=zuobiao(2,:); 
newzuobiao(2,:)=temp(zhixu); 
newzuobiao 
zuobiao=newzuobiao; 
huatu=[zuobiao,zuobiao(:,1)]; 
plot(huatu(1,:),huatu(2,:)),hold on 
plot(huatu(1,:),huatu(2,:),'ro'),hold off 
pause(1); 
f=juli(newzuobiao) 
 
 
%??????????-------------------------------------- 
%???????10000 
tmax=100; 
tmin=0.001; 
%?????????? 
down=0.95; 
 
 
%??????????.. 
t=tmax; 
while t>tmin 
    m=1; 
    for n=1:300 
        newzuobiao=newpath(zuobiao,length); 
        newf=juli(newzuobiao); 
        if newf<f 
           zuobiao=newzuobiao; 
           f=newf; 
        elseif   rand<exp(-(newf-f)/t) 
           zuobiao=newzuobiao; 
           f=newf; 
        else 
            m=m+1; 
            if m>=70 
                m=1; 
                n=n+1; 
            end 
        end 
    end 
    huatu=[zuobiao,zuobiao(:,1)]; 
    plot(huatu(1,:),huatu(2,:)),hold on 
    plot(huatu(1,:),huatu(2,:),'ro'),hold off 
    pause(0.000000001) 
    t=t*down 
    f 
end
 
 
 
