function ds = imd_(DisIntra,DisInter)
% 
% ��������ֵ���Խ��Խ�ã����ں����ķ���ԽСԽ�ã�d ֵԽ��Խ��
%  
u_mean1=mean(DisIntra);
u_mean2=mean(DisInter);
var1=var(DisIntra);
var2=var(DisInter);

d1 = abs(u_mean1 -  u_mean2);
d2=sqrt((var1+var2)/2);   %�����Ǳ�׼���ƽ��
d=d1/d2;
ds=[u_mean1;u_mean2;var1;var2;d];

% save ds ds;