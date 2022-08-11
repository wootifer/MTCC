%%
%
%    画ROC曲线,并返回曲线与两坐标轴所围的面积
%
%%
function  [auc,eer] = plot_c( DisIntra ,DisInter )

num_DisIntra = length(DisIntra); %获取类内海明距离的个数
num_DisInter = length(DisInter);  %获取类间海明距离的个数

%%  Genuine and imposter distributions
% figure;
x1 = 0:0.005:1;  %区间步长为0.005
y1 = hist(DisIntra,x1);   %计算类内各区间值的个数
yy1 = y1/num_DisIntra *100;  %各区间个数占总数的百分比
y2 = hist(DisInter,x1);   %计算类间各区间值的个数
yy2 = y2/num_DisInter *100;  %各区间个数占总数的百分比
plot(x1,yy1,'r.-',x1,yy2,'g*-','LineWidth',1.5);
legend('Genuine','Impster','Location','northwest');
axis([0 0.6 0 17]);    %规定横轴和纵轴的范围
xlabel('Matching distance');
ylabel('Percentage(%)');
title('Genuine and imposter distributions');

%% 计算EER
FRR = [];
GAR = [];
FAR = [];
% 写法1
% EER = [];
% threshold = 0:0.01:1;  %设置阈值
% for i = 1:length(threshold)
%     frr = sum(DisIntra > threshold(i))/num_DisIntra;   %大于预设阈值的 就错误的拒绝了
%     FRR = [FRR frr];
%     gar = sum(DisIntra < threshold(i))/num_DisIntra;    %小于预设阈值的 正确接受
%     GAR = [GAR gar];
%     far = sum(DisInter < threshold(i))/num_DisInter;   %小于阈值的  就错误的接受了
%     FAR = [FAR far];
% %     if (abs(frr-far)<0.02) %frr和far值相差很小时认为相等
% %         eer = abs(frr+far)/2;
% %         EER = [EER eer];
% %     end
% end
% eer = min(EER);

% 写法2
for threshold = 0:0.01:1
    frr = sum(DisIntra > threshold)/num_DisIntra;   %类内大于预设阈值的，错误的拒绝了
    FRR = [FRR frr];
    gar = sum(DisIntra <= threshold)/num_DisIntra;   %类内小于预设阈值的，正确接受
    GAR = [GAR gar];
    far = sum(DisInter <= threshold)/num_DisInter;   %类间小于阈值的，就错误的接受了
    FAR = [FAR far];
end

[~, EERindex]=min(abs(FAR-FRR));
eer = (FAR(EERindex)+FRR(EERindex))/2;

%% 画ROC     
% figure;
% plot(FAR,FRR,'-r','LineWidth',2);
% xlabel('FAR(%)');  %错误接受率
% ylabel('FRR(%)');   %错误拒绝率
% plot(FAR, FRR, 'r.-');
% plot(threshold,FRR,'r.-',threshold,FAR,'g*-','LineWidth',1.5);
% legend('FRR','FAR','Location','southwest');

%% FRR-FAR
semilogx(FAR, FRR,'-p');
axis([1e-05 1 0 0.1]);

xlabel('FAR(%)');  % 错误接受率
ylabel('FRR(%)');  % 错误拒绝率
title('ROC曲线图');
%计算小矩形的面积,返回auc
auc = 1 - trapz(FAR,FRR);        %该值越大，说明正确率越高
%% GAR-FAR
% figure,
semilogx(FAR, GAR,'-p');
axis([1e-05 1 0.98 1]);

xlabel('FAR(%)');  % 错误接受率
ylabel('GAR(%)');  % 正确接受率
title('ROC曲线图');
% hold on;
%%  作直线y = x,直线与ROC的交点即为EER
% x=0:0.25:1; 
% y = x; 
% plot(x, y); 
% hold off;
% EER = intersect(FAR,FRR);

end
