%%
%
%    画ROC曲线,并返回曲线与两坐标轴所围的面积
%
%%
function plot_dis( DisIntra ,DisInter )

num_DisIntra = length(DisIntra); %获取类内海明距离的个数
num_DisInter = length(DisInter);  %获取类间海明距离的个数

%%  Genuine and imposter distributions
figure;
x1 = 0:0.005:1;  %区间步长为0.005
y1 = hist(DisIntra,x1);   %计算类内各区间值的个数
yy1 = y1/num_DisIntra *100;  %各区间个数占总数的百分比
y2 = hist(DisInter,x1);   %计算类间各区间值的个数
yy2 = y2/num_DisInter *100;  %各区间个数占总数的百分比
plot(x1,yy1,'r.-',x1,yy2,'g*-','LineWidth',1);
legend('Genuine','Impster','Location','northwest');
axis([0 0.6 0 25]);    %规定横轴和纵轴的范围
xlabel('Matching distance');
ylabel('Percentage(%)');
title('Genuine and imposter distributions on MS-R');

