%%
%
%    ��ROC����,����������������������Χ�����
%
%%
function plot_dis( DisIntra ,DisInter )

num_DisIntra = length(DisIntra); %��ȡ���ں�������ĸ���
num_DisInter = length(DisInter);  %��ȡ��亣������ĸ���

%%  Genuine and imposter distributions
figure;
x1 = 0:0.005:1;  %���䲽��Ϊ0.005
y1 = hist(DisIntra,x1);   %�������ڸ�����ֵ�ĸ���
yy1 = y1/num_DisIntra *100;  %���������ռ�����İٷֱ�
y2 = hist(DisInter,x1);   %������������ֵ�ĸ���
yy2 = y2/num_DisInter *100;  %���������ռ�����İٷֱ�
plot(x1,yy1,'r.-',x1,yy2,'g*-','LineWidth',1);
legend('Genuine','Impster','Location','northwest');
axis([0 0.6 0 25]);    %�涨���������ķ�Χ
xlabel('Matching distance');
ylabel('Percentage(%)');
title('Genuine and imposter distributions on MS-R');

