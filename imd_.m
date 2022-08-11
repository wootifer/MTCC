function ds = imd_(DisIntra,DisInter)
% 
% 类内类间均值相差越大越好，类内和类间的方差越小越好，d 值越大越好
%  
u_mean1=mean(DisIntra);
u_mean2=mean(DisInter);
var1=var(DisIntra);
var2=var(DisInter);

d1 = abs(u_mean1 -  u_mean2);
d2=sqrt((var1+var2)/2);   %方差是标准差的平方
d=d1/d2;
ds=[u_mean1;u_mean2;var1;var2;d];

% save ds ds;