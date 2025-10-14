function sc=check_sc2(x,y,k)

PD2=pdist2(x,y);

m1 = min(PD2');
sc1=sum(m1<=k)/length(m1)*100;


m2 = min(PD2);
sc2=sum(m2<=k)/length(m2)*100;


sc=[sc1 sc2];